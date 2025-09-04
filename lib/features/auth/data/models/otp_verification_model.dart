// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:customer_app/features/auth/domain/entities/otp_verification_entity.dart';

// Project imports:

part 'otp_verification_model.g.dart';

@immutable
@JsonSerializable()
class OtpVerificationModel extends OtpVerificationEntity {
  const OtpVerificationModel({
    required super.token,
    required super.isNewUser,
    required super.role,
  });

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationModelToJson(this);
}
