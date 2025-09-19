// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/login/data/models/login_request_model.dart';

abstract class LoginRepository {
  Future<ApiResult<void>> login(LoginRequestModel request);
}
