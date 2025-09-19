// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'api_envelope.g.dart';

const _statusSuccess = 'success';

@JsonSerializable(genericArgumentFactories: true)
class ApiEnvelope<T> {
  final String status; // "success" | "error"
  final String? message; // UX copy
  final T? data; // payload (empty {} or [], never null)
  final ApiErrorDetail? error; // present only on failure
  final ApiMeta? meta; // request metadata

  const ApiEnvelope({
    required this.status,
    this.message,
    this.data,
    this.error,
    this.meta,
  });

  bool get isSuccess => status == _statusSuccess;

  factory ApiEnvelope.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiEnvelopeFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$ApiEnvelopeToJson(this, toJsonT);
}

@JsonSerializable()
class ApiErrorDetail {
  final String code;
  final String message;

  const ApiErrorDetail({required this.code, required this.message});

  factory ApiErrorDetail.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorDetailToJson(this);
}

@JsonSerializable()
class ApiMeta {
  final String requestId;
  final String timestamp;
  final bool? hasMore;
  final String? nextCursor;

  const ApiMeta({
    required this.requestId,
    required this.timestamp,
    this.hasMore,
    this.nextCursor,
  });

  factory ApiMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiMetaFromJson(json);
  Map<String, dynamic> toJson() => _$ApiMetaToJson(this);
}
