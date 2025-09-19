// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:customer_app/core/entities/user_entity.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.mobileNumber,
    required super.role,
    required super.token,
    required super.isNewUser,
    super.name,
    super.email,
    super.location,
  });

  /// Creates a [UserModel] instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Converts this [UserModel] instance into a JSON map.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
