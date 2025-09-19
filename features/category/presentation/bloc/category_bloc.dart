// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';
import 'package:customer_app/features/category/domain/usecases/category_usecase.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  /* ── dependencies ── */
  final GetCategoriesUseCase _getCategories;

  /* ── pagination state ── */
  final _catItems = <CategoryEntity>[];
  String? _cursor;
  bool _hasMore = true;

  /* ── constructor ── */
  CategoryBloc({
    required GetCategoriesUseCase getCategories,
  })  : _getCategories = getCategories,
        super(const CategoriesInitial()) {
    on<CategoriesRequested>(_onCategoriesRequested,
        transformer: bc.droppable());
    on<CategoriesNextPageRequested>(_onCategoriesNextPageRequested,
        transformer: bc.droppable());
    on<CategoriesRefresh>(_onCategoriesRefresh, transformer: bc.droppable());
  }

  /* ─────────────────────  Initial Categories Load  ───────────────────── */
  Future<void> _onCategoriesRequested(
      CategoriesRequested event, Emitter<CategoryState> emit) async {
    // Reset pagination state for fresh load
    _catItems.clear();
    _cursor = null;
    _hasMore = true;

    emit(const CategoriesLoading());

    final result = await _getCategories(const CategoryParams(limit: 5));
    await result.when(
      success: (DataWithMeta<List<CategoryEntity>> resp) async {
        _catItems.addAll(resp.data);
        _hasMore = resp.hasNextPage;
        _cursor = resp.nextCursor;

        emit(CategoriesSuccess(List.unmodifiable(_catItems), _hasMore));
      },
      failure: (error) async => emit(CategoriesFailure(error.message)),
    );
  }

  /* ─────────────────────  Next Page Load  ───────────────────── */
  Future<void> _onCategoriesNextPageRequested(
      CategoriesNextPageRequested event, Emitter<CategoryState> emit) async {
    if (!_hasMore) return;

    emit(CategoriesLoading(List.unmodifiable(_catItems)));

    final result =
        await _getCategories(CategoryParams(cursor: _cursor, limit: 5));
    await result.when(
      success: (DataWithMeta<List<CategoryEntity>> resp) async {
        _catItems.addAll(resp.data);
        _hasMore = resp.hasNextPage;
        _cursor = resp.nextCursor;

        emit(CategoriesSuccess(List.unmodifiable(_catItems), _hasMore));
      },
      failure: (error) async => emit(CategoriesFailure(error.message)),
    );
  }

  /* ─────────────────────  Refresh Categories  ───────────────────── */
  Future<void> _onCategoriesRefresh(
      CategoriesRefresh event, Emitter<CategoryState> emit) async {
    // Reset pagination state for fresh load
    _catItems.clear();
    _cursor = null;
    _hasMore = true;

    final result = await _getCategories(const CategoryParams(limit: 5));
    await result.when(
      success: (DataWithMeta<List<CategoryEntity>> resp) async {
        _catItems.addAll(resp.data);
        _hasMore = resp.hasNextPage;
        _cursor = resp.nextCursor;

        emit(CategoriesSuccess(List.unmodifiable(_catItems), _hasMore));
      },
      failure: (error) async => emit(CategoriesFailure(error.message)),
    );
  }
}
