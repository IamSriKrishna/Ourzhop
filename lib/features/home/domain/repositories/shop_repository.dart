import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/home/data/models/shop_model.dart';

abstract class ShopRepository {
  Future<ApiResult<ShopLocationResponseModel>> getShopsByLocation({
    int? limit,
    required double lat,
    required double lng,
    String? cursor,
  });
}
