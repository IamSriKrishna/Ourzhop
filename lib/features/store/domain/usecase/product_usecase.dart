import 'package:customer_app/features/store/data/model/product_model.dart';
import 'package:customer_app/features/store/domain/repositories/product_repository.dart';
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';

@immutable
class GetShopProductsUseCase
    extends UseCaseHelper<ProductsResponseModel, GetShopProductsParams> {
  final ProductRepository productRepository;

  const GetShopProductsUseCase(this.productRepository);

  @override
  Future<ApiResult<ProductsResponseModel>> call(
      GetShopProductsParams params) async {
    return await productRepository.getShopProducts(
      shopId: params.shopId,
      limit: params.limit,
      cursor: params.cursor,
    );
  }
}

@immutable
class GetShopProductsParams {
  final String shopId;
  final int? limit;
  final String? cursor;

  const GetShopProductsParams({
    required this.shopId,
    this.limit,
    this.cursor,
  });
}
