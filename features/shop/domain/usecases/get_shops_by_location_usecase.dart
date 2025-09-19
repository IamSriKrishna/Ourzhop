// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';
import 'package:customer_app/features/shop/domain/repositories/shop_repository.dart';

@immutable
class GetShopsByLocationUseCase
    extends UseCaseHelper<DataWithMeta<List<ShopEntity>>, ShopLocationParams> {
  final ShopRepository shopRepository;

  const GetShopsByLocationUseCase(this.shopRepository);

  @override
  Future<ApiResult<DataWithMeta<List<ShopEntity>>>> call(
      ShopLocationParams params) async {
    return await shopRepository.getShopsByLocation(
      lat: params.lat,
      lng: params.lng,
      limit: params.limit,
      cursor: params.cursor,
      categoryId: params.categoryId,
    );
  }
}

@immutable
class ShopLocationParams {
  final double lat;
  final double lng;
  final int? limit;
  final String? cursor;
  final String? categoryId;

  const ShopLocationParams({
    required this.lat,
    required this.lng,
    this.limit,
    this.cursor,
    this.categoryId,
  });
}
