// error_handler.dart

import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'app_exception.dart';

class ErrorHandler {
  static AppException handleException(error) {
    if (error is d.DioException) {
      switch (error.type) {
        case d.DioException.connectionTimeout:
        case d.DioException.sendTimeout:
        case d.DioException.receiveTimeout:
          return FetchDataException("Connection Timeout");
        case d.DioException.badResponse:
          switch (error.response?.statusCode) {
            case 400:
              return BadRequestException("Bad Request", error.requestOptions.path);
            case 401:
            case 403:
              return UnauthorizedException("Unauthorized", error.requestOptions.path);
            case 404:
              return FetchDataException("Resource Not Found", error.requestOptions.path);
            case 500:
              return FetchDataException("Internal Server Error", error.requestOptions.path);
            default:
              return FetchDataException("Received invalid status code: ${error.response?.statusCode}", error.requestOptions.path);
          }
        case d.DioException.requestCancelled:
          return AppException("Request to API server was cancelled");
        case d.DioExceptionType.unknown:
          return AppException("Unexpected error occurred");
        default:
          return AppException("Unexpected error occurred");
      }
    } else if (error is SocketException) {
      return FetchDataException("No Internet connection");
    } else {
      return AppException("Unexpected error occurred");
    }
  }
}
