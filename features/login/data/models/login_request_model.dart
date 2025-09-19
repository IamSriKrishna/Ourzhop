// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

/// Login request model for API calls
///
/// This model provides type-safe request construction for login API calls.
/// The build.yaml configuration automatically converts camelCase field names
/// to snake_case in the generated JSON (phoneNumber → phone_number).
@immutable
@JsonSerializable()
class LoginRequestModel {
  /// The phone number for login request
  final String phoneNumber;

  const LoginRequestModel({required this.phoneNumber});

  /// Converts this [LoginRequestModel] instance into a JSON map.
  /// Uses automatic snake_case conversion via build.yaml configuration.
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
