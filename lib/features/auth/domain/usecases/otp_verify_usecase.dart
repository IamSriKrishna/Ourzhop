// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/auth/data/models/otp_verification_model.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';

@immutable
class OtpVerifyUseCase extends UseCaseHelper<OtpVerificationModel, OtpParams> {
  final AuthRepository authRepository;

  const OtpVerifyUseCase(this.authRepository);

  @override
  Future<ApiResult<OtpVerificationModel>> call(OtpParams params) async {
    return await authRepository.otpVerify(params.mobileNumber, params.otp);
  }
}

@immutable
class OtpParams {
  final String mobileNumber;
  final String otp;

  const OtpParams(this.mobileNumber, this.otp);
}
