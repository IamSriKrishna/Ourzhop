// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';
import 'package:customer_app/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl extends ShopRepository with RepositoryHelper {
  final ShopRemoteDataSource remoteDataSource;
  ShopRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<DataWithMeta<List<ShopEntity>>>> getShopsByLocation({
    required double lat,
    required double lng,
    int? limit,
    String? cursor,
    String? categoryId,
  }) =>
      checkItemFailOrSuccess(() => remoteDataSource.getShopsByLocation(
            lat: lat,
            lng: lng,
            limit: limit,
            cursor: cursor,
            categoryId: categoryId,
          ));
}
