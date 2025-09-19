// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';

abstract class SetLocationRepository {
  Future<ApiResult<List<SetLocationModel>>> searchPlaces(String input);
}
