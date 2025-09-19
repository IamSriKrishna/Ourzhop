// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/otp/data/models/otp_model.dart';
import 'package:customer_app/features/otp/data/models/otp_request_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class OtpRemoteDataSource {
  Future<OtpModel> otpVerify(OtpRequestModel request);
}

class OtpRemoteDataSourceImpl with ApiHelper implements OtpRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<OtpModel> otpVerify(OtpRequestModel request) => post<OtpModel>(
        _client.dio.post(
          ApiConfig.otpVerify,
          data: request.toJson(),
        ),
        parse: OtpModel.fromJson,
      );
}
