// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:equatable/equatable.dart';

@immutable
class CategoryEntity extends Equatable {
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

  final String categoryId;
  final String name;
  final String description;
  final String slug;
  final String iconUrl;
  final int displayOrder;
  final bool supportsDietary;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        categoryId,
        name,
        description,
        slug,
        iconUrl,
        displayOrder,
        supportsDietary,
        createdAt,
        updatedAt,
      ];
}
