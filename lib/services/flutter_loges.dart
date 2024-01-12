import 'dart:async';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:movie_app/services/dio_methods.dart';

String logFileName = "ForAnyTimeAstroFile";
String tag = "ForAnyTimeAstro";
String appName = "ForAnyTimeAstro";

class FlutterLogger {
  static final FlutterLogger _logger = FlutterLogger._internal();

  FlutterLogger._internal();

  factory FlutterLogger() {
    return _logger;
  }

  static String fileName = "DebugLog";
  static final Completer _completers = Completer<String>();

  Future<void> setUpLogs() async {
    await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.INFO,
        LogLevel.WARNING,
        LogLevel.ERROR,
        LogLevel.SEVERE
      ],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.SINGLE_FILE_FOR_DAY,
      logTypesEnabled: [logFileName],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: "${appName}Logs",
      logsExportDirectoryName: "${appName}Logs/Exported",
      debugFileOperations: false,
      isDebuggable: false,
      autoClearLogs: false,
      singleLogFileSize: 10,
    );

    // [IMPORTANT] The first log line must never be called before 'FlutterLogs.initLogs'
    FlutterLogs.logInfo(tag, "setUpLogs", "setUpLogs: Setting up logs..");

    // Logs Exported Callback
    FlutterLogs.channel.setMethodCallHandler((call) async {
      if (call.method == 'logsExported') {
        // Contains file name of zip
        FlutterLogs.logInfo(tag, "setUpLogs--------------------",
            "logsExported: ${call.arguments.toString()}");
        // Notify Future with value
        _completers.complete(call.arguments.toString());
      } else if (call.method == 'logsPrinted') {
        FlutterLogs.logInfo(
            tag, "setUpLogs", "logsPrinted: ${call.arguments.toString()}");
      }
    });
  }

  Future<void> logToFile({
    required String message,
    bool localLog = false,
    bool debugLog = false,
  }) async {
    if (localLog) {
      appLog(message);
    }
    if (!debugLog) {
      FlutterLogs.logToFile(
        logFileName: logFileName,
        overwrite: false,
        logMessage: "\n\n${DateTime.now()} ::: $message :::",
        appendTimeStamp: false,
      );
    }
  }

  Future<String> exportAllLogs() async {
    FlutterLogs.exportLogs(exportType: ExportType.ALL);
    return _completers.future as FutureOr<String>;
  }

  void printMyLog(String tag, String msg) {
    FlutterLogs.logInfo(tag, "path", 'Path: $msg');
  }

  void clearLogs() {
    FlutterLogs.clearLogs();
  }
}
