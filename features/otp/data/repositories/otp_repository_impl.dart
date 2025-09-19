// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/otp/data/datasources/otp_remote_data_source.dart';
import 'package:customer_app/features/otp/data/models/otp_model.dart';
import 'package:customer_app/features/otp/data/models/otp_request_model.dart';
import 'package:customer_app/features/otp/domain/repositories/otp_repository.dart';

class OtpRepositoryImpl extends OtpRepository with RepositoryHelper {
  final OtpRemoteDataSource remoteDataSource;
  OtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<OtpModel>> otpVerify(OtpRequestModel request) =>
      checkItemFailOrSuccess(() => remoteDataSource.otpVerify(request));
}
