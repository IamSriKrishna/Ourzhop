import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/auth/data/models/location_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class LocationRemoteDataSource {
  Future<LocationSearchResponse> searchPlaces(String input);
}

class LocationRemoteDataSourceImpl
    with ApiHelper
    implements LocationRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();
 

  @override
  Future<LocationSearchResponse> searchPlaces(String input) async {
    final response = await _client.dio
        .get(ApiConfig.searchApi, queryParameters: {'input': input});

    return LocationSearchResponse.fromJson(response.data);
  }
}
