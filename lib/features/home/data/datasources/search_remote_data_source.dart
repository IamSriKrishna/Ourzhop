import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/home/data/models/search_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class SearchRemoteDataSource {
  Future<SearchAutocompleteResponseModel> getAutocompleteResults({
    required String query,
    required double lat,
    required double lng,
  });
}

class SearchRemoteDataSourceImpl with ApiHelper implements SearchRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<SearchAutocompleteResponseModel> getAutocompleteResults({
    required String query,
    required double lat,
    required double lng,
  }) async {
    final queryParams = <String, dynamic>{
      'query': query,
      'lat': lat,
      'lng': lng,
    };

    final response = await _client.dio.get(
      ApiConfig.searchAutocomplete,
      queryParameters: queryParams,
    );

    return SearchAutocompleteResponseModel.fromJson(response.data);
  }
}