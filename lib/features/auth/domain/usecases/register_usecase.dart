// Package imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';

// Register Use Case
class RegisterUseCase implements UseCaseHelper<void, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<ApiResult<void>> call(RegisterParams params) async {
    return await _repository.login(params.mobileNumber);
  }
}

// Register Parameters
class RegisterParams {
  final String mobileNumber;

  RegisterParams(this.mobileNumber);
}