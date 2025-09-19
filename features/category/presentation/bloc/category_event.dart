// Package imports:
import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class CategoriesRequested extends CategoryEvent {
  const CategoriesRequested();
}

class CategoriesNextPageRequested extends CategoryEvent {
  const CategoriesNextPageRequested();
}

class CategoriesRefresh extends CategoryEvent {
  const CategoriesRefresh();
}
