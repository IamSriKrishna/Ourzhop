// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/auth/data/models/otp_verification_model.dart';

abstract class AuthRepository {
  Future<ApiResult<void>> login(String mobileNumber);
  Future<ApiResult<OtpVerificationModel>> otpVerify(String mobileNumber, otp);
  Future<ApiResult<void>> accountSetup(String name, email);
}
