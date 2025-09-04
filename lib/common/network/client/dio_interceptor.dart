// Package imports:

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/core/utils/app_logger.dart';
import 'package:customer_app/service_locator.dart';

class DioInterceptor extends Interceptor {
  final AppLogger _logger = AppLogger();
  final AuthPreferenceService _authPreferenceService =
      serviceLocator<AuthPreferenceService>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    _logger.info('Authorization header added.');
    _logger.info('====================START====================');
    _logger.info('HTTP method => ${options.method} ');
    _logger.info(
        'Request => ${options.baseUrl}${options.path}${options.queryParameters.format}');
    _logger.info('Header  => ${options.headers}');
    final user = await _authPreferenceService.getUser();
    if (user?.token != null && user!.token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${user.token}';
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    _logger.error(options.method); // Debug log
    _logger.error('Error: ${err.error}, Message: ${err.message}'); // Error log
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger
        .debug('Response => StatusCode: ${response.statusCode}'); // Debug log
    _logger.debug('Response => Body: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }
}
