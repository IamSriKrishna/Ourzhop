// Dart imports:
import 'dart:convert' as convert;

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:customer_app/common/network/exceptions/api_exception.dart';
import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:customer_app/common/network/models/meta.dart';

typedef Parse<T> = T Function(Map<String, dynamic> json);

mixin ApiHelper {
  /* ───────── core executor ───────── */
  Future<ApiEnvelope<R>> _execute<R>(
    Future<Response> dioCall, {
    Parse<R>? parse,
  }) async {
    try {
      final res = await dioCall;
      final payload = res.data is Map<String, dynamic>
          ? res.data as Map<String, dynamic>
          : convert.json.decode(convert.json.encode(res.data))
              as Map<String, dynamic>;

      final raw = ApiEnvelope<dynamic>.fromJson(payload, (o) => o);

      if (!raw.isSuccess) {
        final e = raw.error!;
        throw ApiException(
          statusCode: res.statusCode,
          message: e.message,
          code: e.code,
        );
      }

      final R? data = parse != null
          ? parse((raw.data ?? <String, dynamic>{}) as Map<String, dynamic>)
          : raw.data as R?;

      return ApiEnvelope<R>(
        status: raw.status,
        message: raw.message,
        data: data,
        meta: raw.meta,
        error: null,
      );
    } on DioException catch (e) {
      throw ApiException(
        statusCode: e.response?.statusCode,
        message: e.message ?? 'Network error',
      );
    }
  }

  /* ───────── generic wrapper ───────── */
  Future<T> _request<T>(
    Future<Response> dioCall, {
    Parse<T>? parse,
  }) async {
    final env = await _execute<T>(dioCall, parse: parse);
    // when T == void, cast is ok (null satisfies void)
    return env.data as T;
  }

  /* ───────── verb helpers ───────── */
  Future<T> post<T>(Future<Response> call, {Parse<T>? parse}) =>
      _request(call, parse: parse);

  Future<T> put<T>(Future<Response> call, {Parse<T>? parse}) =>
      _request(call, parse: parse);

  Future<T> patch<T>(Future<Response> call, {Parse<T>? parse}) =>
      _request(call, parse: parse);

  Future<T> delete<T>(Future<Response> call, {Parse<T>? parse}) =>
      _request(call, parse: parse);

  Future<T> get<T>(
    Future<Response> call,
    Parse<T> parse,
  ) async =>
      (await _execute<T>(call, parse: parse)).data as T;

  /* ───────── list / paged helpers ───────── */
  Future<List<T>> getList<T>(
    Future<Response> call,
    Parse<T> parse,
  ) async {
    final env = await _execute<List<dynamic>>(call);
    return (env.data ?? [])
        .map<T>((e) => parse(e as Map<String, dynamic>))
        .toList();
  }

  Future<DataWithMeta<List<T>>> getPagedList<T>(
    Future<Response> call,
    Parse<T> parse,
  ) async {
    final env = await _execute<List<dynamic>>(call);
    final items = (env.data ?? [])
        .map<T>((e) => parse(e as Map<String, dynamic>))
        .toList();

    final m = env.meta;
    return DataWithMeta<List<T>>(
      data: items,
      meta: MetaInfo(
        requestId: m?.requestId,
        timestamp: m?.timestamp,
        hasMore: m?.hasMore,
        nextCursor: m?.nextCursor,
      ),
    );
  }
}
