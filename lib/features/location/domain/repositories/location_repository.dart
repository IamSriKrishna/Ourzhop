import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';

abstract class LocationRepository {
  Future<ApiResult<LocationSearchResponse>> searchPlaces(String input);
}