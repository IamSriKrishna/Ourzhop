// dio_exceptions.dart

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:customer_app/core/app_string.dart';

class DioExceptions implements Exception {
  final String message;
  final int? statusCode;

  DioExceptions.fromDioError(DioException dioException)
      : statusCode = dioException.response?.statusCode,
        message = _getMessage(dioException);

  static String _getMessage(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return AppString.cancelRequest;
      case DioExceptionType.connectionTimeout:
        return AppString.connectionTimeOut;
      case DioExceptionType.receiveTimeout:
        return AppString.receiveTimeOut;
      case DioExceptionType.badResponse:
        return _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
      case DioExceptionType.sendTimeout:
        return AppString.sendTimeOut;
      case DioExceptionType.connectionError:
        return AppString.socketException;
      default:
        return AppString.unknownError;
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    if (error is Map<String, dynamic>) {
      // Adjust the key based on your API's error response structure
      final apiMessage = error['message'] ?? AppString.unknownError;
      return apiMessage;
    }

    switch (statusCode) {
      case 400:
        return AppString.badRequest;
      case 401:
        return AppString.unauthorized;
      case 403:
        return AppString.forbidden;
      case 404:
        return AppString.notFound;
      case 422:
        return AppString.duplicateEmail;
      case 500:
        return AppString.internalServerError;
      case 502:
        return AppString.badGateway;
      default:
        return AppString.unknownError;
    }
  }

  @override
  String toString() => message;
}
