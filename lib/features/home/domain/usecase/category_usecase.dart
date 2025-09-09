// Flutter imports:
import 'package:customer_app/features/home/data/models/category_model.dart';
import 'package:customer_app/features/home/domain/repositories/category_repository.dart';
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';

@immutable
class GetCategoriesUseCase extends UseCaseHelper<CategoriesResponseModel, GetCategoriesParams> {
  final CategoryRepository categoryRepository;

  const GetCategoriesUseCase(this.categoryRepository);

  @override
  Future<ApiResult<CategoriesResponseModel>> call(GetCategoriesParams params) async {
    return await categoryRepository.getCategories(
      limit: params.limit,
      cursor: params.cursor,
    );
  }
}

@immutable
class GetCategoriesParams {
  final int? limit;
  final String? cursor;

  const GetCategoriesParams({
    this.limit,
    this.cursor,
  });
}