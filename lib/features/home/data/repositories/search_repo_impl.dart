import 'package:customer_app/common/network/models/api_error.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/home/data/datasources/search_remote_data_source.dart';
import 'package:customer_app/features/home/data/models/search_model.dart';
import 'package:customer_app/features/home/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  const SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<SearchAutocompleteResponseModel>> getAutocompleteResults({
    required String query,
    required double lat,
    required double lng,
  }) async {
    try {
      final result = await remoteDataSource.getAutocompleteResults(
        query: query,
        lat: lat,
        lng: lng,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ApiError(message: e.toString()));
    }
  }
}