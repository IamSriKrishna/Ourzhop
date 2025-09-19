// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/otp/data/models/otp_model.dart';
import 'package:customer_app/features/otp/data/models/otp_request_model.dart';

abstract class OtpRepository {
  Future<ApiResult<OtpModel>> otpVerify(OtpRequestModel request);
}
