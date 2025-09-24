
import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:customer_app/features/home/domain/entities/shop_entities.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

part 'shop_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ShopModel extends ShopEntity {
  const ShopModel({
    required super.shopId,
    required super.name,
    required super.isOnline,
    required super.isDeliveryEnabled,
    required super.deliveryReadyTime,
    required super.isPickupEnabled,
    required super.pickupReadyTime,
    required super.distanceKm,
    required super.primaryImageUrl,
    required super.shopTags,
    required super.area,
    required super.city,
    required super.pincode,
    required super.avgRating,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class ShopLocationResponseModel {
  final String status;
  final String message;
  final List<ShopModel> data;
  final ApiMeta meta;

  const ShopLocationResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ShopLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ShopLocationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopLocationResponseModelToJson(this);

  ShopLocationResponseEntity toEntity() => ShopLocationResponseEntity(
    status: status,
    message: message,
    data: data,
    meta: meta,
  );
}