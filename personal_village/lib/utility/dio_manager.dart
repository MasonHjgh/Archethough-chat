import 'package:dio/dio.dart';
import 'package:personal_village/utility/logging_interceptor.dart';

class DioManager {
  final Dio dio = Dio();

  DioManager() {
    BaseOptions options = BaseOptions(
        receiveTimeout: const Duration(seconds: 100),
        connectTimeout: const Duration(seconds: 100));

    Map<String, dynamic> customHeaders = {
      'content-type': 'application/json',
    };
    options.headers.addAll(customHeaders);
    dio.options = options;
    dio.interceptors.add(LoggingInterceptor());
  }
}
