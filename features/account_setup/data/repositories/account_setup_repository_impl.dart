// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/account_setup/data/datasources/account_setup_remote_data_source.dart';
import 'package:customer_app/features/account_setup/data/models/account_setup_request_model.dart';
import 'package:customer_app/features/account_setup/domain/repositories/account_setup_repository.dart';

class AccountSetupRepositoryImpl extends AccountSetupRepository
    with RepositoryHelper {
  final AccountSetupRemoteDataSource remoteDataSource;
  AccountSetupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<void>> accountSetup(AccountSetupRequestModel request) =>
      checkItemFailOrSuccess(() => remoteDataSource.accountSetup(request));
}
