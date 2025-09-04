// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerificationModel _$OtpVerificationModelFromJson(
        Map<String, dynamic> json) =>
    OtpVerificationModel(
      token: json['token'] as String,
      isNewUser: json['is_new_user'] as bool,
      role: json['role'] as String,
    );

Map<String, dynamic> _$OtpVerificationModelToJson(
        OtpVerificationModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'is_new_user': instance.isNewUser,
      'role': instance.role,
    };
