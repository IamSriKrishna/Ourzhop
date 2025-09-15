
import 'package:customer_app/features/home/data/models/shop_model.dart';
import 'package:customer_app/features/home/domain/repositories/shop_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';

@immutable
class GetShopsByLocationUseCase extends UseCaseHelper<ShopLocationResponseModel, GetShopsByLocationParams> {
  final ShopRepository shopRepository;

  const GetShopsByLocationUseCase(this.shopRepository);

  @override
  Future<ApiResult<ShopLocationResponseModel>> call(GetShopsByLocationParams params) async {
    return await shopRepository.getShopsByLocation(
      limit: params.limit,
      lat: params.lat,
      lng: params.lng,
      cursor: params.cursor,
    );
  }
}

@immutable
class GetShopsByLocationParams {
  final int? limit;
  final double lat;
  final double lng;
  final String? cursor;

  const GetShopsByLocationParams({
    this.limit,
    required this.lat,
    required this.lng,
    this.cursor,
  });
}