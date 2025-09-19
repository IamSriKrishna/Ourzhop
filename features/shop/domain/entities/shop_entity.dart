// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:equatable/equatable.dart';

@immutable
class ShopEntity extends Equatable {
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

  @override
  List<Object?> get props => [
        shopId,
        name,
        isOnline,
        isDeliveryEnabled,
        deliveryReadyTime,
        isPickupEnabled,
        pickupReadyTime,
        distanceKm,
        primaryImageUrl,
        shopTags,
        area,
        city,
        pincode,
        avgRating,
      ];
}
