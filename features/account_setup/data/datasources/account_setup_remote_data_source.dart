// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/account_setup/data/models/account_setup_request_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class AccountSetupRemoteDataSource {
  Future<void> accountSetup(AccountSetupRequestModel request);
}

class AccountSetupRemoteDataSourceImpl
    with ApiHelper
    implements AccountSetupRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<void> accountSetup(AccountSetupRequestModel request) => post<void>(
        _client.dio.post(
          ApiConfig.accountSetup,
          data: request.toJson(),
        ),
      );
}
