// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

@immutable
class SetLocationEntity {
  final String placeId;
  final String description;
  final String mainText;
  final String secondaryText;
  final double latitude;
  final double longitude;

  const SetLocationEntity({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
    required this.latitude,
    required this.longitude,
  });
}
