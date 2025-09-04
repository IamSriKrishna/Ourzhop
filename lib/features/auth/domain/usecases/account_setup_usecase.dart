// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';

@immutable
class AccountSetupUseCase extends UseCaseHelper<void, AccountParams> {
  final AuthRepository authRepository;

  const AccountSetupUseCase(this.authRepository);

  @override
  Future<ApiResult<void>> call(AccountParams params) async {
    return await authRepository.accountSetup(params.name, params.email);
  }
}

@immutable
class AccountParams {
  final String name;
  final String email;

  const AccountParams(this.name, this.email);
}
