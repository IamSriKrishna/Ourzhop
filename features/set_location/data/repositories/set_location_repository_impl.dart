// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/set_location/data/datasources/set_location_remote_data_source.dart';
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';
import 'package:customer_app/features/set_location/domain/repositories/set_location_repository.dart';

class SetLocationRepositoryImpl extends SetLocationRepository
    with RepositoryHelper {
  final SetLocationRemoteDataSource remoteDataSource;

  SetLocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<SetLocationModel>>> searchPlaces(String input) =>
      checkItemFailOrSuccess(() => remoteDataSource.searchPlaces(input));
}
