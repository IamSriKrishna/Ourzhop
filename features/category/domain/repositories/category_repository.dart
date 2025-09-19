// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<ApiResult<DataWithMeta<List<CategoryEntity>>>> getCategories({
    int? limit,
    String? cursor,
  });
}
