// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/features/category/domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoryState {
  const CategoriesInitial();
}

class CategoriesLoading extends CategoryState {
  const CategoriesLoading([this.categories = const []]);

  final List<CategoryEntity> categories;

  @override
  List<Object?> get props => [categories];
}

class CategoriesSuccess extends CategoryState {
  const CategoriesSuccess(this.categories, this.hasMore);

  final List<CategoryEntity> categories;
  final bool hasMore;

  @override
  List<Object?> get props => [categories, hasMore];
}

class CategoriesFailure extends CategoryState {
  const CategoriesFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
