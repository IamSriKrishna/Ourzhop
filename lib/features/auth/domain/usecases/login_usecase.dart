// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';

@immutable
class LoginUseCase extends UseCaseHelper<void, LoginParams> {
  final AuthRepository authRepository;

  const LoginUseCase(this.authRepository);

  @override
  Future<ApiResult<void>> call(LoginParams params) async {
    return await authRepository.login(params.mobileNumber);
  }
}

@immutable
class LoginParams {
  final String mobileNumber;

  const LoginParams(this.mobileNumber);
}
