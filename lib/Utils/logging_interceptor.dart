// logging_interceptor.dart
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request [${options.method}] => PATH: ${options.path}');
    print('Request Headers: ${options.headers}');
    print('Request Data: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response [${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('Response Headers: ${response.headers}');
    print('Response Data: ${response.data}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Error Message: ${err.message}');
    print('Error Data: ${err.response?.data}');

    super.onError(err, handler);
  }
}
