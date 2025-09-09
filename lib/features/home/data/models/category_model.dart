// Flutter imports:
import 'package:customer_app/features/home/domain/entities/category_entities.dart';
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.categoryId,
    required super.name,
    required super.description,
    required super.slug,
    required super.iconUrl,
    required super.displayOrder,
    required super.supportsDietary,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class CategoriesResponseModel {
  final String status;
  final String message;
  final List<CategoryModel> data;
  final MetaModel meta;

  const CategoriesResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseModelToJson(this);

  // Convert to entity
  CategoriesResponseEntity toEntity() => CategoriesResponseEntity(
    status: status,
    message: message,
    data: data,
    meta: meta,
  );
}

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class MetaModel extends MetaEntity {
  const MetaModel({
    required super.requestId,
    required super.timestamp,
    required super.hasMore,
    super.nextCursor,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MetaModelToJson(this);
}