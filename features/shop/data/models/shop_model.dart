// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';

part 'shop_model.g.dart';

/// Shop model for API responses
///
/// This model provides type-safe JSON deserialization for shop API responses.
/// The build.yaml configuration automatically converts snake_case field names
/// to camelCase in Dart (shop_id → shopId, is_online → isOnline, etc.).
@immutable
@JsonSerializable()
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

  /// Creates a [ShopModel] from a JSON map.
  /// Uses automatic camelCase conversion via build.yaml configuration.
  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  /// Converts this [ShopModel] instance into a JSON map.
  /// Uses automatic snake_case conversion via build.yaml configuration.
  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
