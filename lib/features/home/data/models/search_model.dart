import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:customer_app/features/home/domain/entities/search_entities.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required super.id,
    required super.type,
    required super.name,
    required super.description,
    required super.similarityScore,
    required super.distanceKm,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class SearchAutocompleteResponseModel {
  final String status;
  final String message;
  final List<SearchResultModel> data;
  final ApiMeta meta;

  const SearchAutocompleteResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory SearchAutocompleteResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchAutocompleteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchAutocompleteResponseModelToJson(this);

  SearchAutocompleteResponseEntity toEntity() => SearchAutocompleteResponseEntity(
    status: status,
    message: message,
    data: data,
    meta: meta,
  );
}