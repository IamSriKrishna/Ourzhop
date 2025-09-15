import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/home/data/models/search_model.dart';

abstract class SearchRepository {
  Future<ApiResult<SearchAutocompleteResponseModel>> getAutocompleteResults({
    required String query,
    required double lat,
    required double lng,
  });
}