// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';
import 'package:customer_app/features/shop/domain/usecases/get_shops_by_location_usecase.dart';
import 'package:customer_app/features/shop/presentation/bloc/shop_event.dart';
import 'package:customer_app/features/shop/presentation/bloc/shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetShopsByLocationUseCase _getShopsByLocation;
  final List<ShopEntity> _shopItems = [];
  String? _cursor;
  bool _hasMore = true;

  ShopBloc({
    required GetShopsByLocationUseCase getShopsByLocation,
  })  : _getShopsByLocation = getShopsByLocation,
        super(const ShopsInitial()) {
    on<ShopsRequested>(_onShopsRequested);
    on<ShopsNextPageRequested>(_onShopsNextPageRequested);
    on<ShopsRefresh>(_onShopsRefresh);
  }

  Future<void> _onShopsRequested(
    ShopsRequested event,
    Emitter<ShopState> emit,
  ) async {
    // TODO: Implement shops request logic using _getShopsByLocation usecase
    emit(const ShopsLoading());

    // Placeholder implementation - replace with actual logic
    // Example:
    // final result = await _getShopsByLocation(ShopLocationParams(...));
    // result.when(success: ..., failure: ...);
    emit(const ShopsSuccess([], false));
  }

  Future<void> _onShopsNextPageRequested(
    ShopsNextPageRequested event,
    Emitter<ShopState> emit,
  ) async {
    // TODO: Implement next page request logic using _cursor and _hasMore
    // Use existing _cursor for pagination
  }

  Future<void> _onShopsRefresh(
    ShopsRefresh event,
    Emitter<ShopState> emit,
  ) async {
    // TODO: Implement refresh logic
    _shopItems.clear();
    _cursor = null;
    _hasMore = true;

    // Placeholder - replace with actual refresh logic using _getShopsByLocation
    emit(const ShopsLoading());
    emit(const ShopsSuccess([], false));
  }
}
