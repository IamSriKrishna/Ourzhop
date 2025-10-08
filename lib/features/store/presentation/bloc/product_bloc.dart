import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/features/store/domain/usecase/get_shop_filters_usecase.dart';
import 'package:customer_app/features/store/domain/usecase/product_usecase.dart';
import 'package:customer_app/features/store/presentation/bloc/product_event.dart';
import 'package:customer_app/features/store/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetShopProductsUseCase getShopProducts;
  final GetShopFiltersUseCase getShopFilters;

  ProductBloc({
    required this.getShopProducts,
    required this.getShopFilters,
  }) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<RefreshProductsEvent>(_onRefreshProducts);
    on<ClearProductsEvent>(_onClearProducts);
    on<LoadFiltersEvent>(_onLoadFilters);
    on<ApplyFiltersEvent>(_onApplyFilters);
    on<ResetFiltersEvent>(_onResetFilters);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductSuccess) {
      final currentState = state as ProductSuccess;
      if (currentState.shopId == event.shopId) {
        Logger().i(
            '⚠️ Products already loaded for shop ${event.shopId}, skipping reload');
        return;
      }
      Logger().i(
          '🔄 Switching from shop ${currentState.shopId} to ${event.shopId}');
    }

    emit(ProductLoading());

    try {
      // Load both products and filters
      final productsResult = await getShopProducts(
        GetShopProductsParams(
          shopId: event.shopId,
          limit: event.limit,
          cursor: event.cursor,
        ),
      );

      final filtersResult = await getShopFilters(
        GetShopFiltersParams(shopId: event.shopId),
      );

      productsResult.when(
        success: (productsResponse) {
          filtersResult.when(
            success: (filtersResponse) {
              Logger().i('✅ Products loaded: ${productsResponse.data.length}');
              Logger().i('✅ Filters loaded successfully');
              
              if (productsResponse.data.isEmpty) {
                emit(ProductEmpty());
              } else {
                emit(ProductSuccess(
                  products: productsResponse.data,
                  hasMore: productsResponse.meta.hasMore ?? false,
                  shopId: event.shopId,
                  filters: filtersResponse.data,
                ));
              }
            },
            failure: (error) {
              // If filters fail, still show products
              Logger().w('⚠️ Filter error: ${error.message}');
              if (productsResponse.data.isEmpty) {
                emit(ProductEmpty());
              } else {
                emit(ProductSuccess(
                  products: productsResponse.data,
                  hasMore: productsResponse.meta.hasMore ?? false,
                  shopId: event.shopId,
                ));
              }
            },
          );
        },
        failure: (error) {
          Logger().e('❌ Product error: ${error.message}');
          emit(ProductError(error.message));
        },
      );
    } catch (e, stackTrace) {
      Logger().e('❌ Exception in _onLoadProducts: $e');
      Logger().e('Stack trace: $stackTrace');
      emit(ProductError('Failed to load products: $e'));
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getShopProducts(
      GetShopProductsParams(
        shopId: event.shopId,
        limit: event.limit,
        cursor: null,
      ),
    );

    result.when(
      success: (response) {
        if (response.data.isEmpty) {
          emit(ProductEmpty());
        } else {
          emit(ProductSuccess(
            products: response.data,
            hasMore: response.meta.hasMore ?? false,
            shopId: event.shopId,
          ));
        }
      },
      failure: (error) {
        emit(ProductError(error.message));
      },
    );
  }

  void _onClearProducts(
    ClearProductsEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductInitial());
  }

  Future<void> _onLoadFilters(
    LoadFiltersEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    
    if (currentState is ProductSuccess) {
      // Keep products visible while loading filters
      emit(currentState.copyWith());
    }

    try {
      final result = await getShopFilters(
        GetShopFiltersParams(shopId: event.shopId),
      );

      result.when(
        success: (response) {
          Logger().i('✅ Filters loaded successfully');
          
          if (currentState is ProductSuccess) {
            emit(currentState.copyWith(filters: response.data));
          } else {
            emit(FilterSuccess(
              filters: response.data,
              shopId: event.shopId,
            ));
          }
        },
        failure: (error) {
          Logger().e('❌ Filter error: ${error.message}');
          emit(FilterError(error.message));
        },
      );
    } catch (e, stackTrace) {
      Logger().e('❌ Exception in _onLoadFilters: $e');
      Logger().e('Stack trace: $stackTrace');
      emit(FilterError('Failed to load filters: $e'));
    }
  }

  void _onApplyFilters(
    ApplyFiltersEvent event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductSuccess) {
      // Here you would typically make an API call with filter parameters
      // For now, we'll just update the state with applied filters
      emit(currentState.copyWith(
        appliedFilters: event.selectedFilters,
      ));
      
      Logger().i('✅ Filters applied: ${event.selectedFilters}');
    }
  }

  void _onResetFilters(
    ResetFiltersEvent event,
    Emitter<ProductState> emit,
  ) {
    final currentState = state;
    
    if (currentState is ProductSuccess) {
      emit(currentState.copyWith(
        appliedFilters: {},
      ));
      
      Logger().i('✅ Filters reset');
    }
  }
}