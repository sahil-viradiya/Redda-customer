import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:redda_customer/Utils/error_handler.dart';
import 'auth_interceptor.dart';
import 'logging_interceptor.dart';

const int _defaultConnectTimeout = 5000;
const int _defaultReceiveTimeout = 5000;

class DioClient {
  final String baseUrl;

  Dio _dio = Dio();

  final List<Interceptor>? interceptors;

  DioClient(
    this.baseUrl,
    Dio dio, {
    this.interceptors,
  }) {
    _dio = dio;
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout = const Duration(milliseconds: _defaultReceiveTimeout)
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    // Add the interceptors
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(LoggingInterceptor());

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: false,
      ));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (error) {
      throw ErrorHandler.handleException(error);
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    log("Param==================>>>>>$data $queryParameters");
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      log('Status Code====>>   ${response.statusCode}');
      return response.data;
    } catch (error) {
      throw ErrorHandler.handleException(error);
    }
  }
}
