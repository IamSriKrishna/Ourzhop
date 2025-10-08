
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/store/data/model/filter_model.dart';
import 'package:customer_app/features/store/data/model/product_model.dart';

abstract class ProductRepository {
  Future<ApiResult<ProductsResponseModel>> getShopProducts({
    required String shopId,
    int? limit,
    String? cursor,
  });

  Future<ApiResult<ShopFiltersResponseModel>> getShopFilters({
    required String shopId,
  });
}