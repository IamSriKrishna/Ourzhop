// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:customer_app/features/otp/domain/entities/otp_entity.dart';

// Project imports:

part 'otp_model.g.dart';

@immutable
@JsonSerializable()
class OtpModel extends OtpEntity {
  const OtpModel({
    required super.token,
    required super.isNewUser,
    required super.role,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) =>
      _$OtpModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpModelToJson(this);
}
