// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/constants/user_role_constants.dart';
import 'package:customer_app/features/otp/data/models/otp_model.dart';
import 'package:customer_app/features/otp/data/models/otp_request_model.dart';
import 'package:customer_app/features/otp/domain/repositories/otp_repository.dart';

@immutable
class OtpUseCase extends UseCaseHelper<OtpModel, OtpParams> {
  final OtpRepository otpRepository;

  const OtpUseCase(this.otpRepository);

  @override
  Future<ApiResult<OtpModel>> call(OtpParams params) async {
    final request = OtpRequestModel(
      phoneNumber: params.mobileNumber,
      otp: params.otp,
      role: UserRoleConstants.customer, // Fixed: use customer instead of seller
    );
    return await otpRepository.otpVerify(request);
  }
}

@immutable
class OtpParams {
  final String mobileNumber;
  final String otp;

  const OtpParams(this.mobileNumber, this.otp);
}
