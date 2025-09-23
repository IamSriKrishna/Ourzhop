import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/location/data/datasource/location_remote_data_source.dart';
import 'package:customer_app/features/location/domain/repositories/location_repository.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';

class LocationRepositoryImpl extends LocationRepository with RepositoryHelper {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<LocationSearchResponse>> searchPlaces(String input) =>
      checkItemFailOrSuccess(() => remoteDataSource.searchPlaces(input));
}
