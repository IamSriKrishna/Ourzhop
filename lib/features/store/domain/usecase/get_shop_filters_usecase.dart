import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/store/data/model/filter_model.dart';
import 'package:customer_app/features/store/domain/repositories/product_repository.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class GetShopFiltersUseCase
    extends UseCaseHelper<ShopFiltersResponseModel, GetShopFiltersParams> {
  final ProductRepository productRepository;

  const GetShopFiltersUseCase(this.productRepository);

  @override
  Future<ApiResult<ShopFiltersResponseModel>> call(
      GetShopFiltersParams params) async {
    return await productRepository.getShopFilters(
      shopId: params.shopId,
    );
  }
}

@immutable
class GetShopFiltersParams {
  final String shopId;

  const GetShopFiltersParams({
    required this.shopId,
  });
}