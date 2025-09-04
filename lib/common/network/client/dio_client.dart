// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:customer_app/common/network/client/dio_interceptor.dart';
import 'package:customer_app/common/network/config/api_config.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio.options
      ..baseUrl = ApiConfig.baseUrl
      ..headers = ApiConfig.header
      ..connectTimeout = ApiConfig.connectionTimeout
      ..receiveTimeout = ApiConfig.receiveTimeout
      ..responseType = ResponseType.json
      ..validateStatus = (_) => true; // 👈 keep body for all statuses

    dio.interceptors.add(DioInterceptor());
  }
}
