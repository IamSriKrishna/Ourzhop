// lib/common/repository/repository_helper.dart

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:customer_app/common/network/exceptions/api_exception.dart';
import 'package:customer_app/common/network/models/api_error.dart';
import 'package:customer_app/common/network/result/api_result.dart';

mixin RepositoryHelper {
  Future<ApiResult<T>> checkItemFailOrSuccess<T>(
    Future<T> Function() remoteCall,
  ) async {
    try {
      final data = await remoteCall();
      return ApiResult.success(data);
    } on ApiException catch (e) {
      return ApiResult.failure(
        ApiError(statusCode: e.statusCode, message: e.message),
      );
    } on DioException catch (e) {
      // non-HTTP network errors (timeout, TLS, etc.)
      return ApiResult.failure(
        ApiError(statusCode: e.response?.statusCode, message: e.message ?? ''),
      );
    } catch (e) {
      return ApiResult.failure(ApiError(message: e.toString()));
    }
  }
}
