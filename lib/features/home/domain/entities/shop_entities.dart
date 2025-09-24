import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class ShopEntity {
  final String shopId;
  final String name;
  final bool isOnline;
  final bool isDeliveryEnabled;
  final String deliveryReadyTime;
  final bool isPickupEnabled;
  final String pickupReadyTime;
  final double distanceKm;
  final String primaryImageUrl;
  final List<String> shopTags;
  final String area;
  final String city;
  final String pincode;
  final double avgRating;

  const ShopEntity({
    required this.shopId,
    required this.name,
    required this.isOnline,
    required this.isDeliveryEnabled,
    required this.deliveryReadyTime,
    required this.isPickupEnabled,
    required this.pickupReadyTime,
    required this.distanceKm,
    required this.primaryImageUrl,
    required this.shopTags,
    required this.area,
    required this.city,
    required this.pincode,
    required this.avgRating,
  });
}

@immutable
class ShopLocationResponseEntity {
  final String status;
  final String message;
  final List<ShopEntity> data;
  final ApiMeta meta;

  const ShopLocationResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });
}