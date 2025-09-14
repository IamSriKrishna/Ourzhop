import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/auth/data/models/location_model.dart';

abstract class LocationRepository {
  Future<ApiResult<LocationSearchResponse>> searchPlaces(String input);
}