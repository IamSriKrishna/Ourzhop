// Flutter imports:
import 'package:customer_app/features/home/data/models/category_model.dart';
import 'package:customer_app/features/home/domain/usecase/category_usecase.dart';
import 'package:flutter/foundation.dart' show immutable;

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
part 'home_event.dart';
part 'home_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategories;

  CategoryBloc({
    required this.getCategories,
  }) : super(CategoryInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<LoadMoreCategoriesEvent>(_onLoadMoreCategories);
    on<RefreshCategoriesEvent>(_onRefreshCategories);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final result = await getCategories(GetCategoriesParams(
      limit: event.limit,
      cursor: event.cursor,
    ));

    result.when(
      success: (data) => emit(CategoryLoaded(
        categories: data.data,
        meta: data.meta,
        isLoadingMore: false,
      )),
      failure: (failure) => emit(CategoryError(failure.message)),
    );
  }

  Future<void> _onLoadMoreCategories(
    LoadMoreCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final currentState = state;
    if (currentState is CategoryLoaded &&
        currentState.meta.hasMore &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      final result = await getCategories(GetCategoriesParams(
        limit: event.limit,
        cursor: currentState.meta.nextCursor,
      ));

      result.when(
        success: (data) => emit(CategoryLoaded(
          categories: [...currentState.categories, ...data.data],
          meta: data.meta,
          isLoadingMore: false,
        )),
        failure: (failure) => emit(currentState.copyWith(
          isLoadingMore: false,
          error: failure.message,
        )),
      );
    }
  }

  Future<void> _onRefreshCategories(
    RefreshCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    final result = await getCategories(GetCategoriesParams(
      limit: event.limit,
    ));

    result.when(
      success: (data) => emit(CategoryLoaded(
        categories: data.data,
        meta: data.meta,
        isLoadingMore: false,
      )),
      failure: (failure) => emit(CategoryError(failure.message)),
    );
  }
}
