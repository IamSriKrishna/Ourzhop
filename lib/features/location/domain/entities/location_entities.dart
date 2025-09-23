import 'package:flutter/foundation.dart' show immutable;

@immutable
class LocationEntity {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;
  final double latitude;
  final double longitude;

  const LocationEntity({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
    required this.latitude,
    required this.longitude,
  });
}
