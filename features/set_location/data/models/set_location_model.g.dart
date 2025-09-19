// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetLocationModel _$SetLocationModelFromJson(Map<String, dynamic> json) =>
    SetLocationModel(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
      mainText: json['main_text'] as String,
      secondaryText: json['secondary_text'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$SetLocationModelToJson(SetLocationModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'description': instance.description,
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
