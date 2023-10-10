import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  static const int _maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("--> ${options.method} ${options.path}");
    debugPrint("Content type: ${options.contentType}");
    debugPrint(
        "Request data: ${options.data is FormData ? (options.data as FormData).fields : options.data}");
    debugPrint("Query params: ${options.queryParameters}");
    debugPrint("Header: ${options.headers}");
    debugPrint("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        debugPrint(
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      debugPrint(response.data);
    }
    debugPrint("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("<-- Error -->");
    debugPrint(err.error.toString());
    debugPrint(err.message);
    return super.onError(err, handler);
  }
}
