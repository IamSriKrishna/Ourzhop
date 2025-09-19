// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:customer_app/features/set_location/domain/entities/set_location_entity.dart';

part 'set_location_model.g.dart';

/// Location search result model for API responses
///
/// This model represents a single location result from the search API.
/// Uses automatic snake_case conversion configured in build.yaml.
@immutable
@JsonSerializable()
class SetLocationModel extends SetLocationEntity {
  const SetLocationModel({
    required super.placeId,
    required super.description,
    required super.mainText,
    required super.secondaryText,
    required super.latitude,
    required super.longitude,
  });

  factory SetLocationModel.fromJson(Map<String, dynamic> json) =>
      _$SetLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetLocationModelToJson(this);
}
