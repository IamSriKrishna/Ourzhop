// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_envelope.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiEnvelope<T> _$ApiEnvelopeFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiEnvelope<T>(
      status: json['status'] as String,
      message: json['message'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      error: json['error'] == null
          ? null
          : ApiErrorDetail.fromJson(json['error'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : ApiMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiEnvelopeToJson<T>(
  ApiEnvelope<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'error': instance.error,
      'meta': instance.meta,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

ApiErrorDetail _$ApiErrorDetailFromJson(Map<String, dynamic> json) =>
    ApiErrorDetail(
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ApiErrorDetailToJson(ApiErrorDetail instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

ApiMeta _$ApiMetaFromJson(Map<String, dynamic> json) => ApiMeta(
      requestId: json['request_id'] as String,
      timestamp: json['timestamp'] as String,
      hasMore: json['has_more'] as bool?,
      nextCursor: json['next_cursor'] as String?,
    );

Map<String, dynamic> _$ApiMetaToJson(ApiMeta instance) => <String, dynamic>{
      'request_id': instance.requestId,
      'timestamp': instance.timestamp,
      'has_more': instance.hasMore,
      'next_cursor': instance.nextCursor,
    };
