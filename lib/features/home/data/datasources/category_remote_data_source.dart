// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/home/data/models/category_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class CategoryRemoteDataSource {
  Future<CategoriesResponseModel> getCategories({
    int? limit,
    String? cursor,
  });
}

class CategoryRemoteDataSourceImpl
    with ApiHelper
    implements CategoryRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<CategoriesResponseModel> getCategories({
    int? limit,
    String? cursor,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (cursor != null && cursor.isNotEmpty) queryParams['cursor'] = cursor;

    final response = await _client.dio.get(
      ApiConfig.categories,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );

    return CategoriesResponseModel.fromJson(response.data);
  }
}
