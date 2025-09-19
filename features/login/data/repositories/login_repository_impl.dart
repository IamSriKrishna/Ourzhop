// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/login/data/datasources/login_remote_data_source.dart';
import 'package:customer_app/features/login/data/models/login_request_model.dart';
import 'package:customer_app/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository with RepositoryHelper {
  final LoginRemoteDataSource remoteDataSource;
  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<void>> login(LoginRequestModel request) =>
      checkItemFailOrSuccess(() => remoteDataSource.login(request));
}
