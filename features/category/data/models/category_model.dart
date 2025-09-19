// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:customer_app/features/category/domain/entities/category_entity.dart';

part 'category_model.g.dart';

/// Category model for API responses
///
/// This model provides type-safe JSON deserialization for category API responses.
/// The build.yaml configuration automatically converts snake_case field names
/// to camelCase in Dart (created_at → createdAt).
@immutable
@JsonSerializable()
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

  /// Creates a [CategoryModel] from a JSON map.
  /// Uses automatic camelCase conversion via build.yaml configuration.
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  /// Converts this [CategoryModel] instance into a JSON map.
  /// Uses automatic snake_case conversion via build.yaml configuration.
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
