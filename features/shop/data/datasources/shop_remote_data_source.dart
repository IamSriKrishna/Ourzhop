// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/features/shop/data/models/shop_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class ShopRemoteDataSource {
  Future<DataWithMeta<List<ShopModel>>> getShopsByLocation({
    required double lat,
    required double lng,
    int? limit,
    String? cursor,
    String? categoryId,
  });
}

class ShopRemoteDataSourceImpl with ApiHelper implements ShopRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<DataWithMeta<List<ShopModel>>> getShopsByLocation({
    required double lat,
    required double lng,
    int? limit,
    String? cursor,
    String? categoryId,
  }) =>
      getPagedList<ShopModel>(
        _client.dio.get(
          ApiConfig.shopsLocation,
          queryParameters: {
            'lat': lat,
            'lng': lng,
            if (limit != null) 'limit': limit,
            if (cursor != null) 'cursor': cursor,
            if (categoryId != null) 'category_id': categoryId,
          },
        ),
        ShopModel.fromJson,
      );
}
