// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'account_setup_request_model.g.dart';

/// Account setup request model for API calls
///
/// This model provides type-safe request construction for account setup API calls.
/// The build.yaml configuration automatically converts camelCase field names
/// to snake_case in the generated JSON if needed.
@immutable
@JsonSerializable()
class AccountSetupRequestModel {
  /// User's full name
  final String name;

  /// User's email address
  final String email;

  const AccountSetupRequestModel({
    required this.name,
    required this.email,
  });

  /// Converts this [AccountSetupRequestModel] instance into a JSON map.
  /// Uses automatic snake_case conversion via build.yaml configuration.
  Map<String, dynamic> toJson() => _$AccountSetupRequestModelToJson(this);
}
