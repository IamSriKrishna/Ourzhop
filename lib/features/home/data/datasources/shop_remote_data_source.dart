
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/common/network/config/api_config.dart';
import 'package:customer_app/common/network/helpers/api_helper.dart';
import 'package:customer_app/features/home/data/models/shop_model.dart';
import 'package:customer_app/service_locator.dart';

abstract class ShopRemoteDataSource {
  Future<ShopLocationResponseModel> getShopsByLocation({
    int? limit,
    required double lat,
    required double lng,
    String? cursor,
  });
}

class ShopRemoteDataSourceImpl with ApiHelper implements ShopRemoteDataSource {
  final DioClient _client = serviceLocator<DioClient>();

  @override
  Future<ShopLocationResponseModel> getShopsByLocation({
    int? limit,
    required double lat,
    required double lng,
    String? cursor,
  }) async {
    final queryParams = <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
    
    if (limit != null) queryParams['limit'] = limit;
    if (cursor != null && cursor.isNotEmpty) queryParams['cursor'] = cursor;

    final response = await _client.dio.get(
      ApiConfig.shopsLocation, 
      queryParameters: queryParams,
    );

    return ShopLocationResponseModel.fromJson(response.data);
  }
}
