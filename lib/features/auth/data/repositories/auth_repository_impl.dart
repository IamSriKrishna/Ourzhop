// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:customer_app/features/auth/data/models/otp_verification_model.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository with RepositoryHelper {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<void>> login(String mobileNumber) =>
      checkItemFailOrSuccess(() => remoteDataSource.login(mobileNumber));

  @override
  Future<ApiResult<OtpVerificationModel>> otpVerify(String mobileNumber, otp) =>
      checkItemFailOrSuccess(
          () => remoteDataSource.otpVerify(mobileNumber, otp));

  @override
  Future<ApiResult<void>> accountSetup(String name, email) =>
      checkItemFailOrSuccess(() => remoteDataSource.accountSetup(name, email));
}
