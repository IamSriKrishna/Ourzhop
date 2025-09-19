// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/account_setup/data/models/account_setup_request_model.dart';

abstract class AccountSetupRepository {
  Future<ApiResult<void>> accountSetup(AccountSetupRequestModel request);
}
