

import 'package:customer_app/features/location/domain/entities/location_entities.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';
part 'location_model.g.dart';

@immutable
@JsonSerializable()
class LocationModel extends LocationEntity {
  const LocationModel({
    required super.placeId,
    required super.description,
    required super.mainText,
    required super.secondaryText,
    required super.latitude,
    required super.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@immutable
@JsonSerializable()
class LocationSearchResponse {
  final String status;
  final String message;
  final List<LocationModel> data;

  const LocationSearchResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LocationSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchResponseToJson(this);
}