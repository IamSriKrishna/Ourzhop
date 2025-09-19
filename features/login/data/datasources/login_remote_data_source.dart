// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/login/data/models/login_request_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class LoginRemoteDataSource {
  Future<void> login(LoginRequestModel request);
}

class LoginRemoteDataSourceImpl
    with ApiHelper
    implements LoginRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<void> login(LoginRequestModel request) => post<void>(
        _client.dio.post(
          ApiConfig.login,
          data: request.toJson(),
        ),
      );
}
