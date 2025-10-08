
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/store/data/datasource/product_remote_data_source.dart';
import 'package:customer_app/features/store/data/model/filter_model.dart';
import 'package:customer_app/features/store/data/model/product_model.dart';
import 'package:customer_app/features/store/domain/repositories/product_repository.dart';


class ProductRepositoryImpl extends ProductRepository with RepositoryHelper {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<ProductsResponseModel>> getShopProducts({
    required String shopId,
    int? limit,
    String? cursor,
  }) =>
      checkItemFailOrSuccess(() => remoteDataSource.getShopProducts(
            shopId: shopId,
            limit: limit,
            cursor: cursor,
          ));

  @override
  Future<ApiResult<ShopFiltersResponseModel>> getShopFilters({
    required String shopId,
  }) =>
      checkItemFailOrSuccess(() => remoteDataSource.getShopFilters(
            shopId: shopId,
          ));
}