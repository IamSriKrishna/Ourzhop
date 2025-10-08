abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {
  final String shopId;
  final int? limit;
  final String? cursor;

  LoadProductsEvent({
    required this.shopId,
    this.limit,
    this.cursor,
  });
}

class RefreshProductsEvent extends ProductEvent {
  final String shopId;
  final int? limit;

  RefreshProductsEvent({
    required this.shopId,
    this.limit,
  });
}

class ClearProductsEvent extends ProductEvent {}

// Add filter events
class LoadFiltersEvent extends ProductEvent {
  final String shopId;

  LoadFiltersEvent({required this.shopId});
}

class ApplyFiltersEvent extends ProductEvent {
  final Map<String, List<String>> selectedFilters;

  ApplyFiltersEvent({required this.selectedFilters});
}

class ResetFiltersEvent extends ProductEvent {}