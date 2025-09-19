// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class SetLocationRemoteDataSource {
  Future<List<SetLocationModel>> searchPlaces(String input);
}

class SetLocationRemoteDataSourceImpl
    with ApiHelper
    implements SetLocationRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<List<SetLocationModel>> searchPlaces(String input) =>
      getList<SetLocationModel>(
        _client.dio.get(
          ApiConfig.searchApi,
          queryParameters: {'input': input},
        ),
        SetLocationModel.fromJson,
      );
}
