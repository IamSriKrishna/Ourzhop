
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/store/data/model/filter_model.dart';
import 'package:customer_app/features/store/data/model/product_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponseModel> getShopProducts({
    required String shopId,
    int? limit,
    String? cursor,
  });
  
  Future<ShopFiltersResponseModel> getShopFilters({
    required String shopId,
  });
}

class ProductRemoteDataSourceImpl
    with ApiHelper
    implements ProductRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<ProductsResponseModel> getShopProducts({
    required String shopId,
    int? limit,
    String? cursor,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (cursor != null && cursor.isNotEmpty) queryParams['cursor'] = cursor;

    final response = await _client.dio.get(
      '${ApiConfig.shops}/$shopId/products',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    return ProductsResponseModel.fromJson(response.data);
  }

  @override
  Future<ShopFiltersResponseModel> getShopFilters({
    required String shopId,
  }) async {
    final response = await _client.dio.get(
      '${ApiConfig.shops}/$shopId/filters',
    );

    return ShopFiltersResponseModel.fromJson(response.data);
  }
}