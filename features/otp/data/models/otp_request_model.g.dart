// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpRequestModel _$OtpRequestModelFromJson(Map<String, dynamic> json) =>
    OtpRequestModel(
      phoneNumber: json['phone_number'] as String,
      otp: json['otp'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$OtpRequestModelToJson(OtpRequestModel instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'otp': instance.otp,
      'role': instance.role,
    };
