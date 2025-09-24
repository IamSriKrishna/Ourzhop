// Flutter imports:
import 'package:customer_app/common/network/models/api_envelope.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CategoryEntity {
  final String categoryId;
  final String name;
  final String description;
  final String slug;
  final String iconUrl;
  final int displayOrder;
  final bool supportsDietary;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.description,
    required this.slug,
    required this.iconUrl,
    required this.displayOrder,
    required this.supportsDietary,
    required this.createdAt,
    required this.updatedAt,
  });
}

@immutable
class CategoriesResponseEntity {
  final String status;
  final String message;
  final List<CategoryEntity> data;
  final ApiMeta meta;

  const CategoriesResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.meta,
  });
}
