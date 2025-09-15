
import 'package:customer_app/common/network/models/api_error.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/home/data/datasources/shop_remote_data_source.dart';
import 'package:customer_app/features/home/data/models/shop_model.dart';
import 'package:customer_app/features/home/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;

  const ShopRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<ShopLocationResponseModel>> getShopsByLocation({
    int? limit,
    required double lat,
    required double lng,
    String? cursor,
  }) async {
    try {
      final result = await remoteDataSource.getShopsByLocation(
        limit: limit,
        lat: lat,
        lng: lng,
        cursor: cursor,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiError(message: e.toString()));
    }
  }
}