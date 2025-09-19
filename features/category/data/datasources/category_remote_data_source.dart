// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/features/category/data/models/category_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class CategoryRemoteDataSource {
  Future<DataWithMeta<List<CategoryModel>>> getCategories({
    int? limit,
    String? cursor,
  });
}

class CategoryRemoteDataSourceImpl
    with ApiHelper
    implements CategoryRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<DataWithMeta<List<CategoryModel>>> getCategories({
    int? limit,
    String? cursor,
  }) =>
      getPagedList<CategoryModel>(
        _client.dio.get(
          ApiConfig.categories,
          queryParameters: {
            if (limit != null) 'limit': limit,
            if (cursor != null) 'cursor': cursor,
          },
        ),
        CategoryModel.fromJson,
      );
}
