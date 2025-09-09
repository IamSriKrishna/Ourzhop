part of 'home_bloc.dart';

@immutable
sealed class CategoryState {}

@immutable
class CategoryInitial extends CategoryState {
   CategoryInitial();
}

@immutable
class CategoryLoading extends CategoryState {
   CategoryLoading();
}

@immutable
class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final MetaModel meta;
  final bool isLoadingMore;
  final String? error;

   CategoryLoaded({
    required this.categories,
    required this.meta,
    required this.isLoadingMore,
    this.error,
  });

  CategoryLoaded copyWith({
    List<CategoryModel>? categories,
    MetaModel? meta,
    bool? isLoadingMore,
    String? error,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}

@immutable
class CategoryError extends CategoryState {
  final String message;

   CategoryError(this.message);
}