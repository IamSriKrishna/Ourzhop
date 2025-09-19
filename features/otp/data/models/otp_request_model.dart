// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'otp_request_model.g.dart';

/// OTP request model for API calls
///
/// This model provides type-safe request construction for OTP verification API calls.
/// The build.yaml configuration automatically converts camelCase field names
/// to snake_case in the generated JSON (phoneNumber → phone_number).
@immutable
@JsonSerializable()
class OtpRequestModel {
  /// The phone number for OTP verification
  final String phoneNumber;

  /// The OTP code to verify
  final String otp;

  /// The user role (customer, seller, admin)
  final String role;

  const OtpRequestModel({
    required this.phoneNumber,
    required this.otp,
    required this.role,
  });

  /// Converts this [OtpRequestModel] instance into a JSON map.
  /// Uses automatic snake_case conversion via build.yaml configuration.
  Map<String, dynamic> toJson() => _$OtpRequestModelToJson(this);
}
