// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/features/category/domain/entities/category_entity.dart';
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Section-Specific States
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// Category section state - mirrors CategoryBloc patterns
abstract class HomeCategoryState extends Equatable {
  const HomeCategoryState();

  @override
  List<Object?> get props => [];
}

class HomeCategoryInitial extends HomeCategoryState {
  const HomeCategoryInitial();
}

class HomeCategoryLoading extends HomeCategoryState {
  const HomeCategoryLoading([this.categories = const []]);

  final List<CategoryEntity> categories;

  @override
  List<Object?> get props => [categories];
}

class HomeCategorySuccess extends HomeCategoryState {
  const HomeCategorySuccess(this.categories, this.hasMore);

  final List<CategoryEntity> categories;
  final bool hasMore;

  @override
  List<Object?> get props => [categories, hasMore];
}

class HomeCategoryFailure extends HomeCategoryState {
  const HomeCategoryFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Shop Section State - mirrors CategoryBloc patterns
// ═══════════════════════════════════════════════════════════════════════════════════════════════

abstract class HomeShopState extends Equatable {
  const HomeShopState();

  @override
  List<Object?> get props => [];
}

class HomeShopInitial extends HomeShopState {
  const HomeShopInitial();
}

class HomeShopLoading extends HomeShopState {
  const HomeShopLoading([this.shops = const []]);

  final List<ShopEntity> shops;

  @override
  List<Object?> get props => [shops];
}

class HomeShopSuccess extends HomeShopState {
  const HomeShopSuccess(this.shops, this.hasMore);

  final List<ShopEntity> shops;
  final bool hasMore;

  @override
  List<Object?> get props => [shops, hasMore];
}

class HomeShopFailure extends HomeShopState {
  const HomeShopFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Recommended Section State (Skeletal for future implementation)
// ═══════════════════════════════════════════════════════════════════════════════════════════════

abstract class HomeRecommendedState extends Equatable {
  const HomeRecommendedState();

  @override
  List<Object?> get props => [];
}

class HomeRecommendedInitial extends HomeRecommendedState {
  const HomeRecommendedInitial();
}

class HomeRecommendedLoading extends HomeRecommendedState {
  const HomeRecommendedLoading();
}

class HomeRecommendedSuccess extends HomeRecommendedState {
  const HomeRecommendedSuccess();
}

class HomeRecommendedFailure extends HomeRecommendedState {
  const HomeRecommendedFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Composite Home State
// ═══════════════════════════════════════════════════════════════════════════════════════════════

class HomeState extends Equatable {
  const HomeState({
    this.categoryState = const HomeCategoryInitial(),
    this.shopState = const HomeShopInitial(),
    this.recommendedState = const HomeRecommendedInitial(),
  });

  final HomeCategoryState categoryState;
  final HomeShopState shopState;
  final HomeRecommendedState recommendedState;

  HomeState copyWith({
    HomeCategoryState? categoryState,
    HomeShopState? shopState,
    HomeRecommendedState? recommendedState,
  }) {
    return HomeState(
      categoryState: categoryState ?? this.categoryState,
      shopState: shopState ?? this.shopState,
      recommendedState: recommendedState ?? this.recommendedState,
    );
  }

  @override
  List<Object?> get props => [categoryState, shopState, recommendedState];
}
