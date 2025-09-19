// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/repository/repository_helper.dart';
import 'package:customer_app/features/category/data/datasources/category_remote_data_source.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';
import 'package:customer_app/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository with RepositoryHelper {
  final CategoryRemoteDataSource remoteDataSource;
  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<DataWithMeta<List<CategoryEntity>>>> getCategories({
    int? limit,
    String? cursor,
  }) =>
      checkItemFailOrSuccess(() => remoteDataSource.getCategories(
            limit: limit,
            cursor: cursor,
          ));
}
