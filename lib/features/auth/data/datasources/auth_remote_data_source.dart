// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/auth/data/models/otp_verification_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class AuthRemoteDataSource {
  Future<void> login(String mobileNumber); // ← void
  Future<OtpVerificationModel> otpVerify(String mobile, String otp);
  Future<void> accountSetup(String name, String email);
}

class AuthRemoteDataSourceImpl with ApiHelper implements AuthRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<void> login(String mobile) => post<void>(
        _client.dio.post(
          ApiConfig.login,
          data: {'phone_number': mobile},
        ),
      );

  @override
  Future<OtpVerificationModel> otpVerify(
    String mobile,
    String otp,
  ) =>
      post<OtpVerificationModel>(
        _client.dio.post(
          ApiConfig.otpVerify,
          data: {
            'phone_number': mobile,
            'otp': otp,
            'role': 'seller',
          },
        ),
        parse: OtpVerificationModel.fromJson,
      );

  @override
  Future<void> accountSetup(String name, String email) => post<void>(
        _client.dio.post(
          ApiConfig.accountSetup,
          data: {'name': name, 'email': email},
        ),
      );
}
