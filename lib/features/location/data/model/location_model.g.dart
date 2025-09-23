// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
      mainText: json['main_text'] as String,
      secondaryText: json['secondary_text'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'description': instance.description,
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

LocationSearchResponse _$LocationSearchResponseFromJson(
        Map<String, dynamic> json) =>
    LocationSearchResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationSearchResponseToJson(
        LocationSearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
