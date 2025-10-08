import 'package:customer_app/features/store/data/model/filter_model.dart';
import 'package:customer_app/features/store/data/model/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<ProductModel> products;
  final bool hasMore;
  final String shopId;
  final ShopFiltersDataModel? filters;
  final Map<String, List<String>> appliedFilters;

  ProductSuccess({
    required this.products,
    required this.hasMore,
    required this.shopId,
    this.filters,
    this.appliedFilters = const {},
  });

  ProductSuccess copyWith({
    List<ProductModel>? products,
    bool? hasMore,
    String? shopId,
    ShopFiltersDataModel? filters,
    Map<String, List<String>>? appliedFilters,
  }) {
    return ProductSuccess(
      products: products ?? this.products,
      hasMore: hasMore ?? this.hasMore,
      shopId: shopId ?? this.shopId,
      filters: filters ?? this.filters,
      appliedFilters: appliedFilters ?? this.appliedFilters,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductEmpty extends ProductState {}

// Filter-specific states
class FilterLoading extends ProductState {}

class FilterSuccess extends ProductState {
  final ShopFiltersDataModel filters;
  final String shopId;

  FilterSuccess({
    required this.filters,
    required this.shopId,
  });
}

class FilterError extends ProductState {
  final String message;
  FilterError(this.message);
}