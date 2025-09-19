// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Project imports:
import 'package:customer_app/common/network/network.dart';
import 'package:customer_app/common/usecase/usecase_helper.dart';
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';
import 'package:customer_app/features/set_location/domain/repositories/set_location_repository.dart';

@immutable
class SetLocationUseCase
    extends UseCaseHelper<List<SetLocationModel>, SetLocationParams> {
  final SetLocationRepository setLocationRepository;

  const SetLocationUseCase(this.setLocationRepository);

  @override
  Future<ApiResult<List<SetLocationModel>>> call(
      SetLocationParams params) async {
    if (params.input.length < 3) {
      return ApiResult.failure(
          ApiError(message: 'Search query must be at least 3 characters long'));
    }
    if (params.input.length > 250) {
      return ApiResult.failure(
          ApiError(message: 'Search query must be less than 250 characters'));
    }

    return await setLocationRepository.searchPlaces(params.input);
  }
}

@immutable
class SetLocationParams {
  final String input;

  const SetLocationParams(this.input);
}
