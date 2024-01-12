import 'dart:io';
import 'package:dio/dio.dart';

enum NetworkReqType {
  emailLogin,
  otpLogin,
  signUp,
  verifyOtp,
  resendOtp,
  forgotPassword,
  missedCall
}

class NetworkExceptions {
  static String getErrorMessage(error) {
    if (error is Exception) {
      try {
        var errorMessage = "";
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorMessage = "requestCancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = "connectionRequestTimeout";
              break;
            case DioExceptionType.unknown:
              errorMessage = "no_internet_conn";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = "something_wrong_no_internet";
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = "something_wrong_no_internet";
              break;
            case DioExceptionType.badCertificate:
              errorMessage = "unauthorised_request";
              break;
            case DioExceptionType.connectionError:
              errorMessage = "no_internet_conn";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                  errorMessage = "unauthorised_request";
                  break;
                case 401:
                  errorMessage = "unauthorised_request";
                  break;
                case 403:
                  errorMessage = "unauthorised_request";
                  break;
                case 404:
                  errorMessage = "not found";
                  break;
                case 409:
                  errorMessage = "errorConflict";
                  break;
                case 408:
                  errorMessage = "connectionRequestTimeout";
                  break;
                case 500:
                  errorMessage = "internalServerError";
                  break;
                case 503:
                  errorMessage = "serviceUnavailable";
                  break;
                default:
                  var responseCode = error.response!.statusCode;
                  errorMessage = "Received invalid status code: $responseCode";
              }
              break;
          }
        } else if (error is SocketException) {
          errorMessage = "no_internet_conn";
        } else {
          errorMessage = "unexpectedErrorOccurred";
        }
        return errorMessage;
      } on FormatException catch (e) {
        // Helper.printError(e.toString());
        return "unexpectedErrorOccurred";
      } catch (_) {
        return "unexpectedErrorOccurred";
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return "unableToProcessData";
      } else {
        return "unexpectedErrorOccurred";
      }
    }
  }
}

class StatusEnum {
  static const int CONTINUE = 100;
  static const int SWITCHING_PROTOCOLS = 101;
  static const int alreadyCompleted = 103;
  static const int OK = 200;
  static const int CREATED = 201;
  static const int ACCEPTED = 202;
  static const int NON_AUTORATIVE_INFORMATION = 203;
  static const int NO_CONTENT = 204;
  static const int RESET_CONTENT = 205;
  static const int PARTIAL_CONTENT = 206;
  static const int MULTIPLE_CHOICES = 300;
  static const int AMBIGOUS = 300;
  static const int MOVED_PERMANENTLY = 301;
  static const int MOVED = 301;
  static const int FOUND = 302;
  static const int REDIRECT = 302;
  static const int SEE_OTHER = 303;
  static const int REDIRECT_METHOD = 303;
  static const int NOT_MODIFIED = 304;
  static const int USE_PROXY = 305;
  static const int UNUSED = 306;
  static const int REDIRECT_KEEP_VERB = 307;
  static const int TemporaryRedirect = 307;
  static const int BAD_REQUEST = 400;
  static const int Unauthorized = 401;
  static const int PaymentRequired = 402;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int MethodNotAllowed = 405;
  static const int NotAcceptable = 406;
  static const int ProxyAuthenticationRequired = 407;
  static const int RequestTimeout = 408;
  static const int CONFLICT = 409;
  static const int Gone = 410;
  static const int LengthRequired = 411;
  static const int PreconditionFailed = 412;
  static const int RequestEntityTooLarge = 413;
  static const int RequestUriTooLong = 414;
  static const int UnsupportedMediaType = 415;
  static const int RequestedRangeNotSatisfiable = 416;
  static const int ExpectationFailed = 417;
  static const int UpgradeRequired = 426;
  static const int InternalServerError = 500;
  static const int NotImplemented = 501;
  static const int BadGateway = 502;
  static const int ServiceUnavailable = 503;
  static const int GatewayTimeout = 504;
  static const int HttpVersionNotSupported = 505;
  static const int inValidRole = 510;
  static const int limitExceed = 429;
}
