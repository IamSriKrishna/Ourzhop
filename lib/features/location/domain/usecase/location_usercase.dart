import 'package:customer_app/common/network/network.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';
import 'package:customer_app/features/location/domain/repositories/location_repository.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';

@immutable
class SearchLocationUseCase
    extends UseCaseHelper<LocationSearchResponse, SearchLocationParams> {
  final LocationRepository locationRepository;

  const SearchLocationUseCase(this.locationRepository);

  @override
  Future<ApiResult<LocationSearchResponse>> call(
      SearchLocationParams params) async {
    if (params.input.length < 3) {
      return ApiResult.failure(
          ApiError(message: 'Search query must be at least 3 characters long'));
    }
    if (params.input.length > 250) {
      return ApiResult.failure(
          ApiError(message: 'Search query must be less than 250 characters'));
    }

    return await locationRepository.searchPlaces(params.input);
  }
}

@immutable
class SearchLocationParams {
  final String input;

  const SearchLocationParams(this.input);
}
