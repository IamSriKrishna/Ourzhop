// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';

abstract class ShopRepository {
  Future<ApiResult<DataWithMeta<List<ShopEntity>>>> getShopsByLocation({
    required double lat,
    required double lng,
    int? limit,
    String? cursor,
    String? categoryId,
  });
}
