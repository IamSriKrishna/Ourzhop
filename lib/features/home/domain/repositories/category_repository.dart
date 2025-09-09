// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/home/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<ApiResult<CategoriesResponseModel>> getCategories({
    int? limit,
    String? cursor,
  });
}