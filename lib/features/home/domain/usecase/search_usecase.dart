import 'package:customer_app/features/home/data/models/search_model.dart';
import 'package:customer_app/features/home/domain/repositories/search_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';

@immutable
class GetAutocompleteResultsUseCase extends UseCaseHelper<SearchAutocompleteResponseModel, GetAutocompleteResultsParams> {
  final SearchRepository searchRepository;

  const GetAutocompleteResultsUseCase(this.searchRepository);

  @override
  Future<ApiResult<SearchAutocompleteResponseModel>> call(GetAutocompleteResultsParams params) async {
    return await searchRepository.getAutocompleteResults(
      query: params.query,
      lat: params.lat,
      lng: params.lng,
    );
  }
}

@immutable
class GetAutocompleteResultsParams {
  final String query;
  final double lat;
  final double lng;

  const GetAutocompleteResultsParams({
    required this.query,
    required this.lat,
    required this.lng,
  });
}