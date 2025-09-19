// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpModel _$OtpModelFromJson(Map<String, dynamic> json) => OtpModel(
      token: json['token'] as String,
      isNewUser: json['is_new_user'] as bool,
      role: json['role'] as String,
    );

Map<String, dynamic> _$OtpModelToJson(OtpModel instance) => <String, dynamic>{
      'token': instance.token,
      'is_new_user': instance.isNewUser,
      'role': instance.role,
    };
