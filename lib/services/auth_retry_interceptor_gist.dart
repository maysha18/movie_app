import 'dart:async';

import 'package:dio/dio.dart';
import 'package:movie_app/services/apiUrl.dart';

Map<String, RequestOptions> map = {};

class AuthInterceptor extends QueuedInterceptorsWrapper {
  Dio dio;

  AuthInterceptor({
    required this.dio,
  });

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = _getHeaders();
    handler.next(options);
  }

  static Map<String, dynamic>? _getHeaders() {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': 'Bearer ${ApiUrl.apiKey}',
    };
    return headers;
  }

  /// Refreshes access token, sets it to header, and resolves cloned request of the original.
  Future<void> refreshAndRedoRequest(
      DioException error, ErrorInterceptorHandler handler) async {
    error.requestOptions.headers = _getHeaders();
    handler.resolve(
      await dio.request(
        error.requestOptions.path,
        data: error.requestOptions.data,
        options: Options(method: error.requestOptions.method),
      ),
    );
  }

  bool tokenInvalidResponse(DioException error) =>
      error.response?.statusCode == 412 || error.response?.statusCode == 401;
}
