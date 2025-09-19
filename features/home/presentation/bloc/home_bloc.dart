// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/models/meta.dart';
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/category/domain/entities/category_entity.dart';
import 'package:customer_app/features/category/domain/usecases/category_usecase.dart';
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';
import 'package:customer_app/features/shop/domain/usecases/get_shops_by_location_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /* ── dependencies ── */
  final GetCategoriesUseCase _getCategories;
  final GetShopsByLocationUseCase _getShopsByLocation;

  /* ── category section pagination state ── */
  final _categoryItems = <CategoryEntity>[];
  String? _categoryCursor;
  bool _categoryHasMore = true;

  /* ── shop section pagination state ── */
  final _shopItems = <ShopEntity>[];
  String? _shopCursor;
  bool _shopHasMore = true;

  /* ── constructor ── */
  HomeBloc({
    required GetCategoriesUseCase getCategories,
    required GetShopsByLocationUseCase getShopsByLocation,
  })  : _getCategories = getCategories,
        _getShopsByLocation = getShopsByLocation,
        super(const HomeState()) {
    // Category section events
    on<HomeCategoryLoadRequested>(_onHomeCategoryLoadRequested,
        transformer: bc.droppable());
    on<HomeCategoryLoadMore>(_onHomeCategoryLoadMore,
        transformer: bc.droppable());
    on<HomeCategoryRefresh>(_onHomeCategoryRefresh,
        transformer: bc.droppable());

    // Shop section events (skeletal for future implementation)
    on<HomeShopLoadRequested>(_onHomeShopLoadRequested,
        transformer: bc.droppable());
    on<HomeShopLoadMore>(_onHomeShopLoadMore, transformer: bc.droppable());
    on<HomeShopRefresh>(_onHomeShopRefresh, transformer: bc.droppable());

    // Recommended section events (skeletal for future implementation)
    on<HomeRecommendedLoadRequested>(_onHomeRecommendedLoadRequested,
        transformer: bc.droppable());
    on<HomeRecommendedLoadMore>(_onHomeRecommendedLoadMore,
        transformer: bc.droppable());
    on<HomeRecommendedRefresh>(_onHomeRecommendedRefresh,
        transformer: bc.droppable());
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // Category Section Event Handlers
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /* ─────────────────────  Initial Category Load  ───────────────────── */
  Future<void> _onHomeCategoryLoadRequested(
      HomeCategoryLoadRequested event, Emitter<HomeState> emit) async {
    // Reset pagination state for fresh load
    _categoryItems.clear();
    _categoryCursor = null;
    _categoryHasMore = true;

    emit(state.copyWith(categoryState: const HomeCategoryLoading()));

    final result = await _getCategories(const CategoryParams(limit: 5));
    await result.when(
      success: (DataWithMeta<List<CategoryEntity>> resp) async {
        _categoryItems.addAll(resp.data);
        _categoryHasMore = resp.hasNextPage;
        _categoryCursor = resp.nextCursor;

        emit(state.copyWith(
            categoryState: HomeCategorySuccess(
                List.unmodifiable(_categoryItems), _categoryHasMore)));
      },
      failure: (error) async => emit(
          state.copyWith(categoryState: HomeCategoryFailure(error.message))),
    );
  }

  /* ─────────────────────  Category Next Page Load  ───────────────────── */
  Future<void> _onHomeCategoryLoadMore(
      HomeCategoryLoadMore event, Emitter<HomeState> emit) async {
    if (!_categoryHasMore) return;

    emit(state.copyWith(
        categoryState: HomeCategoryLoading(List.unmodifiable(_categoryItems))));

    final result =
        await _getCategories(CategoryParams(cursor: _categoryCursor, limit: 5));
    await result.when(
      success: (DataWithMeta<List<CategoryEntity>> resp) async {
        _categoryItems.addAll(resp.data);
        _categoryHasMore = resp.hasNextPage;
        _categoryCursor = resp.nextCursor;

        emit(state.copyWith(
            categoryState: HomeCategorySuccess(
                List.unmodifiable(_categoryItems), _categoryHasMore)));
      },
      failure: (error) async => emit(
          state.copyWith(categoryState: HomeCategoryFailure(error.message))),
    );
  }

  /* ─────────────────────  Refresh Categories  ───────────────────── */
  Future<void> _onHomeCategoryRefresh(
      HomeCategoryRefresh event, Emitter<HomeState> emit) async {
    // Reset pagination state for fresh load
    _categoryItems.clear();
    _categoryCursor = null;
    _categoryHasMore = true;

    final result = await _getCategories(const CategoryParams(limit: 5));
    await result.when(
      success: (DataWithMeta<List<CategoryEntity>> resp) async {
        _categoryItems.addAll(resp.data);
        _categoryHasMore = resp.hasNextPage;
        _categoryCursor = resp.nextCursor;

        emit(state.copyWith(
            categoryState: HomeCategorySuccess(
                List.unmodifiable(_categoryItems), _categoryHasMore)));
      },
      failure: (error) async => emit(
          state.copyWith(categoryState: HomeCategoryFailure(error.message))),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // Shop Section Event Handlers
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  /* ─────────────────────  Initial Shop Load  ───────────────────── */
  Future<void> _onHomeShopLoadRequested(
      HomeShopLoadRequested event, Emitter<HomeState> emit) async {
    // Reset pagination state for fresh load
    _shopItems.clear();
    _shopCursor = null;
    _shopHasMore = true;

    emit(state.copyWith(shopState: const HomeShopLoading()));

    // Use default location parameters (lat: 13.0827, lng: 80.2707 - Chennai)
    // TODO: Replace with actual user location from LocationBloc/PreferencesService
    final result = await _getShopsByLocation(const ShopLocationParams(
      lat: 13.0827,
      lng: 80.2707,
      limit: 5,
    ));

    await result.when(
      success: (DataWithMeta<List<ShopEntity>> resp) async {
        _shopItems.addAll(resp.data);
        _shopHasMore = resp.hasNextPage;
        _shopCursor = resp.nextCursor;

        emit(state.copyWith(
            shopState:
                HomeShopSuccess(List.unmodifiable(_shopItems), _shopHasMore)));
      },
      failure: (error) async =>
          emit(state.copyWith(shopState: HomeShopFailure(error.message))),
    );
  }

  /* ─────────────────────  Shop Next Page Load  ───────────────────── */
  Future<void> _onHomeShopLoadMore(
      HomeShopLoadMore event, Emitter<HomeState> emit) async {
    if (!_shopHasMore) return;

    emit(state.copyWith(
        shopState: HomeShopLoading(List.unmodifiable(_shopItems))));

    // Use default location parameters with cursor for pagination
    final result = await _getShopsByLocation(ShopLocationParams(
      lat: 13.0827,
      lng: 80.2707,
      cursor: _shopCursor,
      limit: 5,
    ));

    await result.when(
      success: (DataWithMeta<List<ShopEntity>> resp) async {
        _shopItems.addAll(resp.data);
        _shopHasMore = resp.hasNextPage;
        _shopCursor = resp.nextCursor;

        emit(state.copyWith(
            shopState:
                HomeShopSuccess(List.unmodifiable(_shopItems), _shopHasMore)));
      },
      failure: (error) async =>
          emit(state.copyWith(shopState: HomeShopFailure(error.message))),
    );
  }

  /* ─────────────────────  Refresh Shops  ───────────────────── */
  Future<void> _onHomeShopRefresh(
      HomeShopRefresh event, Emitter<HomeState> emit) async {
    // Reset pagination state for fresh load
    _shopItems.clear();
    _shopCursor = null;
    _shopHasMore = true;

    // Use default location parameters for refresh
    final result = await _getShopsByLocation(const ShopLocationParams(
      lat: 13.0827,
      lng: 80.2707,
      limit: 5,
    ));

    await result.when(
      success: (DataWithMeta<List<ShopEntity>> resp) async {
        _shopItems.addAll(resp.data);
        _shopHasMore = resp.hasNextPage;
        _shopCursor = resp.nextCursor;

        emit(state.copyWith(
            shopState:
                HomeShopSuccess(List.unmodifiable(_shopItems), _shopHasMore)));
      },
      failure: (error) async =>
          emit(state.copyWith(shopState: HomeShopFailure(error.message))),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════════════════════════
  // Recommended Section Event Handlers (Skeletal for future implementation)
  // ═══════════════════════════════════════════════════════════════════════════════════════════════

  Future<void> _onHomeRecommendedLoadRequested(
      HomeRecommendedLoadRequested event, Emitter<HomeState> emit) async {
    emit(state.copyWith(recommendedState: const HomeRecommendedLoading()));

    // TODO: Implement recommended loading logic
    // For now, just emit success to avoid blocking UI
    emit(state.copyWith(recommendedState: const HomeRecommendedSuccess()));
  }

  Future<void> _onHomeRecommendedLoadMore(
      HomeRecommendedLoadMore event, Emitter<HomeState> emit) async {
    // TODO: Implement recommended pagination logic
  }

  Future<void> _onHomeRecommendedRefresh(
      HomeRecommendedRefresh event, Emitter<HomeState> emit) async {
    // TODO: Implement recommended refresh logic
    emit(state.copyWith(recommendedState: const HomeRecommendedSuccess()));
  }
}
