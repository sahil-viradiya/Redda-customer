// auth_interceptor.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:redda_customer/Utils/constant.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add the authentication token to the headers
    final token = await getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle authentication errors
    if (err.response?.statusCode == 401) {
      // Token might be expired or invalid, trigger a logout
      resate(Get.context!);
    }

    super.onError(err, handler);
  }
}
