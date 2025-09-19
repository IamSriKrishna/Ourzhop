// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'stored_location_model.g.dart';

/// Stored location model for user preference storage
///
/// This model represents the user's selected location stored in local preferences.
/// Contains all necessary information for location-based app functionality.
@immutable
@JsonSerializable()
class StoredLocationModel {
  /// Unique identifier for the place (from Places API)
  final String placeId;

  /// Human-readable description of the location
  final String description;

  /// Main display text for the location (primary text)
  final String mainText;

  /// Secondary display text for the location (subtitle/additional info)
  final String secondaryText;

  /// Latitude coordinate
  final double latitude;

  /// Longitude coordinate
  final double longitude;

  const StoredLocationModel({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
    required this.latitude,
    required this.longitude,
  });

  /// Creates a [StoredLocationModel] instance from a JSON map.
  factory StoredLocationModel.fromJson(Map<String, dynamic> json) =>
      _$StoredLocationModelFromJson(json);

  /// Converts this [StoredLocationModel] instance into a JSON map.
  Map<String, dynamic> toJson() => _$StoredLocationModelToJson(this);
}
