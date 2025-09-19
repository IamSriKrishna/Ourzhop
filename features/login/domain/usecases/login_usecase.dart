// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/login/data/models/login_request_model.dart';
import 'package:customer_app/features/login/domain/repositories/login_repository.dart';

@immutable
class LoginUseCase extends UseCaseHelper<void, LoginParams> {
  final LoginRepository loginRepository;

  const LoginUseCase(this.loginRepository);

  @override
  Future<ApiResult<void>> call(LoginParams params) async {
    final request = LoginRequestModel(phoneNumber: params.mobileNumber);
    return await loginRepository.login(request);
  }
}

@immutable
class LoginParams {
  final String mobileNumber;

  const LoginParams(this.mobileNumber);
}
