// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/account_setup/data/models/account_setup_request_model.dart';
import 'package:customer_app/features/account_setup/domain/repositories/account_setup_repository.dart';

@immutable
class AccountSetupUseCase extends UseCaseHelper<void, AccountParams> {
  final AccountSetupRepository accountSetupRepository;

  const AccountSetupUseCase(this.accountSetupRepository);

  @override
  Future<ApiResult<void>> call(AccountParams params) async {
    final request = AccountSetupRequestModel(
      name: params.name,
      email: params.email,
    );
    return await accountSetupRepository.accountSetup(request);
  }
}

@immutable
class AccountParams {
  final String name;
  final String email;

  const AccountParams(this.name, this.email);
}
