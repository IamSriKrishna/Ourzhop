// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      mobileNumber: json['mobile_number'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
      isNewUser: json['is_new_user'] as bool,
      name: json['name'] as String?,
      email: json['email'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'mobile_number': instance.mobileNumber,
      'role': instance.role,
      'token': instance.token,
      'is_new_user': instance.isNewUser,
      'name': instance.name,
      'email': instance.email,
      'location': instance.location,
    };
