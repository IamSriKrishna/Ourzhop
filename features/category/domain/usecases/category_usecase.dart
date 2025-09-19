// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';
import 'package:customer_app/features/category/domain/repositories/category_repository.dart';

@immutable
class GetCategoriesUseCase
    extends UseCaseHelper<DataWithMeta<List<CategoryEntity>>, CategoryParams> {
  final CategoryRepository categoryRepository;

  const GetCategoriesUseCase(this.categoryRepository);

  @override
  Future<ApiResult<DataWithMeta<List<CategoryEntity>>>> call(
      CategoryParams params) async {
    return await categoryRepository.getCategories(
      limit: params.limit,
      cursor: params.cursor,
    );
  }
}

@immutable
class CategoryParams {
  final int? limit;
  final String? cursor;

  const CategoryParams({
    this.limit,
    this.cursor,
  });
}
