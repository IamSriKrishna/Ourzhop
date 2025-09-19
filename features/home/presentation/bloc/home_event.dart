// Package imports:
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Category Section Events
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// Load categories for the category section
class HomeCategoryLoadRequested extends HomeEvent {
  const HomeCategoryLoadRequested();
}

/// Load more categories (pagination)
class HomeCategoryLoadMore extends HomeEvent {
  const HomeCategoryLoadMore();
}

/// Refresh categories
class HomeCategoryRefresh extends HomeEvent {
  const HomeCategoryRefresh();
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Shop Section Events (Skeletal for future implementation)
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// Load shops for the shop section
class HomeShopLoadRequested extends HomeEvent {
  const HomeShopLoadRequested();
}

/// Load more shops (pagination)
class HomeShopLoadMore extends HomeEvent {
  const HomeShopLoadMore();
}

/// Refresh shops
class HomeShopRefresh extends HomeEvent {
  const HomeShopRefresh();
}

// ═══════════════════════════════════════════════════════════════════════════════════════════════
// Recommended Section Events (Skeletal for future implementation)
// ═══════════════════════════════════════════════════════════════════════════════════════════════

/// Load recommended items for the recommended section
class HomeRecommendedLoadRequested extends HomeEvent {
  const HomeRecommendedLoadRequested();
}

/// Load more recommended items (pagination)
class HomeRecommendedLoadMore extends HomeEvent {
  const HomeRecommendedLoadMore();
}

/// Refresh recommended items
class HomeRecommendedRefresh extends HomeEvent {
  const HomeRecommendedRefresh();
}
