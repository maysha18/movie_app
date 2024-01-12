import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:astro_expert/app/data/firebase.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/services/apiUrl.dart';
import 'package:movie_app/services/auth_retry_interceptor_gist.dart';
import 'package:movie_app/services/flutter_loges.dart';

appLog(dynamic msg) {
  if (kDebugMode) print(msg);
}

class DioMethod {
  static Dio _getDioConfiguration({
    String contentType = '',
    bool retry = false,
    bool auth = true,
  }) {
    BaseOptions options = BaseOptions(
      baseUrl: _getBaseUrl(),
      headers: _getHeaders(contentType),
      connectTimeout: const Duration(seconds: 60 * 1000),
      receiveTimeout: const Duration(seconds: 60 * 1000),
      sendTimeout: const Duration(seconds: 60 * 1000),
    );
    // if (contentType.isNotEmpty) {
    //   options.contentType = contentType;
    // }

    Dio dio = Dio();
    dio.options = options;
    // dio.interceptors.add(DioFirebasePerformanceInterceptor());
    if (auth) {
      dio.interceptors.add(AuthInterceptor(dio: dio));
    }
    if (kDebugMode) {
      dio.interceptors.add(LoggingInterceptor());
    }
    return dio;
  }

  static String _getBaseUrl() {
    return ApiUrl.baseUrl;
  }

  static Map<String, dynamic> _getHeaders(String contentType) {
    Map<String, dynamic> headers = {
      'accept': 'application/json;',
      'Authorization': 'Bearer ${ApiUrl.apiKey}',
    };
    return headers;
  }

  static Future<Map<String, dynamic>> dioGet(String url,
      {Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool auth = true}) async {
    Dio dio = _getDioConfiguration(
      contentType: contentType,
      auth: auth,
    );
    try {
      writeRequestLogs(
        method: "GET",
        url: url,
        queryParams: queryParams,
        data: const {},
      );
      Response response = await dio.get(
        url,
        queryParameters: queryParams,
      );

      writeResponseLogs(response);
      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(url: url, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(url: url, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(url: url, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<dynamic> dioGetDynamic(String url,
      {Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool auth = true}) async {
    Dio dio = _getDioConfiguration(
      contentType: contentType,
      auth: auth,
    );
    try {
      Response response = await dio.get(
        url,
        queryParameters: queryParams,
      );
      return response.data;
    } on DioException catch (e) {
      exceptionLogWrite(url: url, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(url: url, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(url: url, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> dioPost(
      String url, Map<String, dynamic> data,
      {Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool auth = true}) async {
    try {
      writeRequestLogs(
        method: "POST",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      Response response = await _getDioConfiguration(
        contentType: contentType,
        auth: auth,
      ).post(
        url,
        data: jsonEncode(data),
        queryParameters: queryParams,
      );
      writeResponseLogs(response);
      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> dioPostDynamicData(
      String url, dynamic data,
      {Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool auth = true}) async {
    try {
      writeRequestLogs(
        method: "POST",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      Response response = await _getDioConfiguration(
        contentType: contentType,
        auth: auth,
      ).post(
        url,
        data: jsonEncode(data),
        queryParameters: queryParams,
      );
      writeResponseLogs(response);
      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> dioPostCustom(
      String url, Map<String, dynamic> data,
      {Map<String, dynamic> queryParams = const {},
      Map<String, dynamic> headers = const {},
      String contentType = '',
      bool auth = true}) async {
    try {
      writeRequestLogs(
        method: "POST",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      var dio = _getDioConfiguration(
        contentType: contentType,
        auth: auth,
      );
      dio.options.headers = headers;
      Response response = await dio.post(
        url,
        data: jsonEncode(data),
        queryParameters: queryParams,
      );
      writeResponseLogs(response);
      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future dioDownload(
      String url, String path, onReceiveProgress, options) async {
    await _getDioConfiguration().download(
      url,
      path,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );
  }

  static Future<Map<String, dynamic>> dioPut(String url,
      {Map<String, dynamic> data = const {},
      Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool retry = false}) async {
    try {
      writeRequestLogs(
        method: "PUT",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      Response response = await _getDioConfiguration(
        contentType: contentType,
        retry: retry,
      ).put(
        url,
        data: data,
        queryParameters: queryParams,
      );
      writeResponseLogs(response);

      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> dioPutToken(String url,
      {Map<String, dynamic> data = const {},
      Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool retry = false,
      bool auth = true}) async {
    try {
      writeRequestLogs(
        method: "PUT",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      Response response = await _getDioConfiguration(
        contentType: contentType,
        retry: retry,
        auth: auth,
      ).put(
        url,
        data: data,
        queryParameters: queryParams,
      );
      writeResponseLogs(response);

      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> dioDelete(String url,
      {Map<String, dynamic> data = const {},
      Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool auth = true}) async {
    try {
      writeRequestLogs(
        method: "DELETE",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      Response response = await _getDioConfiguration(
        contentType: contentType,
        auth: auth,
      ).delete(
        url,
        data: data,
        queryParameters: queryParams,
      );
      writeResponseLogs(response);

      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static Future<Response> dioDelete2(String url,
      {Map<String, dynamic> data = const {},
      Map<String, dynamic> queryParams = const {},
      String contentType = '',
      bool auth = true}) async {
    // await TokenExpiry.checkTokenValidity();
    try {
      writeRequestLogs(
        method: "DELETE",
        url: url,
        queryParams: queryParams,
        data: data,
      );
      Response response = await _getDioConfiguration(
        contentType: contentType,
        auth: auth,
      ).delete(
        url,
        data: data,
        queryParameters: queryParams,
      );
      writeResponseLogs(response);

      return response;
    } on DioException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      if (e.error is SocketException) {
        throw SocketException(e.toString());
      }
      rethrow;
    } on FormatException catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      throw FormatException(e.toString());
    } catch (e) {
      exceptionLogWrite(
          url: url, data: data, queryParams: queryParams, error: e);
      rethrow;
    }
  }

  static void exceptionLogWrite(
      {required String url,
      dynamic data = const {},
      Map<String, dynamic> queryParams = const {},
      dynamic error = ""}) {
    // String msg = NetworkExceptions.getErrorMessage(error);
    FlutterLogger().logToFile(
      message:
          "\n***********************   exceptionLog   ***********************"
          "\nURL : $url"
          "\nHeader :${_getHeaders("")} "
          "\nDATA :${jsonEncode(data)}"
          "\nQueryParams :${jsonEncode(queryParams)}"
          "\nError :${error.toString()}"
          "\n***********************   exceptionLog  ***********************",
    );
  }

  static void writeRequestLogs(
      {required String method,
      required String url,
      Map<String, dynamic> queryParams = const {},
      dynamic data = const {}}) {
    FlutterLogger().logToFile(
      message: "\n******   REQUEST  ******"
          "\nMethod Type : $method "
          "\nURL : $url"
          "\nHeader : ${_getHeaders("")}"
          "\nQueryParams :${jsonEncode(queryParams)}"
          "\nDATA :${jsonEncode(data)}"
          "\n******   REQUEST  ******",
    );
  }

  static void writeResponseLogs(Response response) {
    var data = response.requestOptions.data;
    FlutterLogger().logToFile(
      message: "\n******   RESPONSE   ******"
          "\nMethod Type : ${response.requestOptions.method} "
          "\nURL : ${response.requestOptions.path} "
          "\nHeader :${jsonEncode(response.requestOptions.headers)} "
          "\nREQUEST DATA :${data is FormData ? "FormData" : jsonEncode(response.requestOptions.data)}"
          "\nQueryParams DATA :${jsonEncode(response.requestOptions.queryParameters)}"
          "\nRESPONSE DATA : ${jsonEncode(response.data)}"
          "\n******   RESPONSE   ******",
    );
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if ( //options.path.endsWith("appupdate") ||
        options.path.endsWith("getproductdetails")) {
    } else {
      appLog("<-------------- REQUEST START -------------->");
      appLog('REQUEST [${options.method}] => URL : ${options.path}');
      appLog('REQUEST => Header : ${options.headers.toString()}');
      appLog('REQUEST => DATA : ${options.data.toString()}');
      appLog('REQUEST => QueryParams : ${jsonEncode(options.queryParameters)}');
      appLog("<-------------- REQUEST END -------------->");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if ( //response.requestOptions.path.endsWith("appupdate") ||
        response.requestOptions.path.endsWith("getproductdetails")) {
    } else {
      appLog("<-------------- RESPONSE START -------------->");
      appLog(
          'RESPONSE [${response.requestOptions.method}] => URL : ${response.requestOptions.path}');
      appLog(
          'RESPONSE => Header : ${response.requestOptions.headers.toString()}');
      appLog(
          'RESPONSE => QueryParams : ${jsonEncode(response.requestOptions.queryParameters)}');
      appLog('RESPONSE [${response.statusCode}] => DATA : ${response.data}');
      debugPrint("<-------------- RESPONSE END -------------->");
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
