// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_setup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountSetupRequestModel _$AccountSetupRequestModelFromJson(
        Map<String, dynamic> json) =>
    AccountSetupRequestModel(
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$AccountSetupRequestModelToJson(
        AccountSetupRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
    };
