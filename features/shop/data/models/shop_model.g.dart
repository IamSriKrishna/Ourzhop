// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
      shopId: json['shop_id'] as String,
      name: json['name'] as String,
      isOnline: json['is_online'] as bool,
      isDeliveryEnabled: json['is_delivery_enabled'] as bool,
      deliveryReadyTime: json['delivery_ready_time'] as String,
      isPickupEnabled: json['is_pickup_enabled'] as bool,
      pickupReadyTime: json['pickup_ready_time'] as String,
      distanceKm: (json['distance_km'] as num).toDouble(),
      primaryImageUrl: json['primary_image_url'] as String,
      shopTags:
          (json['shop_tags'] as List<dynamic>).map((e) => e as String).toList(),
      area: json['area'] as String,
      city: json['city'] as String,
      pincode: json['pincode'] as String,
      avgRating: (json['avg_rating'] as num).toDouble(),
    );

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
      'shop_id': instance.shopId,
      'name': instance.name,
      'is_online': instance.isOnline,
      'is_delivery_enabled': instance.isDeliveryEnabled,
      'delivery_ready_time': instance.deliveryReadyTime,
      'is_pickup_enabled': instance.isPickupEnabled,
      'pickup_ready_time': instance.pickupReadyTime,
      'distance_km': instance.distanceKm,
      'primary_image_url': instance.primaryImageUrl,
      'shop_tags': instance.shopTags,
      'area': instance.area,
      'city': instance.city,
      'pincode': instance.pincode,
      'avg_rating': instance.avgRating,
    };
