// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoredLocationModel _$StoredLocationModelFromJson(Map<String, dynamic> json) =>
    StoredLocationModel(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
      mainText: json['main_text'] as String,
      secondaryText: json['secondary_text'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$StoredLocationModelToJson(
        StoredLocationModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'description': instance.description,
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
