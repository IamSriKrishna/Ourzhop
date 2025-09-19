// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'set_location_request_model.g.dart';

/// Location request model for API calls
///
/// This model provides type-safe request construction for location API calls.
/// Following the same clean structure as login/OTP request models.
@immutable
@JsonSerializable()
class SetLocationRequestModel {
  /// The search query for location
  final String query;

  const SetLocationRequestModel({required this.query});

  /// Converts this [SetLocationRequestModel] instance into a JSON map.
  Map<String, dynamic> toJson() => _$SetLocationRequestModelToJson(this);
}
