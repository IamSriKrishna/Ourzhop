
import 'package:customer_app/features/home/data/models/category_model.dart';
import 'package:customer_app/features/home/data/models/shop_model.dart';
import 'package:customer_app/features/home/domain/usecase/shop_usecase.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/common/network/result/api_result.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final GetShopsByLocationUseCase getShopsByLocation;

  ShopBloc({
    required this.getShopsByLocation,
  }) : super(ShopInitial()) {
    on<GetShopsByLocationEvent>(_onGetShopsByLocation);
    on<LoadMoreShopsEvent>(_onLoadMoreShops);
    on<RefreshShopsEvent>(_onRefreshShops);
  }

  Future<void> _onGetShopsByLocation(
    GetShopsByLocationEvent event,
    Emitter<ShopState> emit,
  ) async {
    emit(ShopLoading());

    final result = await getShopsByLocation(GetShopsByLocationParams(
      limit: event.limit,
      lat: event.lat,
      lng: event.lng,
      cursor: event.cursor,
    ));

    result.when(
      success: (data) => emit(ShopLoaded(
        shops: data.data,
        meta: data.meta,
        isLoadingMore: false,
      )),
      failure: (failure) => emit(ShopError(failure.message)),
    );
  }

  Future<void> _onLoadMoreShops(
    LoadMoreShopsEvent event,
    Emitter<ShopState> emit,
  ) async {
    final currentState = state;
    if (currentState is ShopLoaded &&
        currentState.meta.hasMore &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      final result = await getShopsByLocation(GetShopsByLocationParams(
        limit: event.limit,
        lat: event.lat,
        lng: event.lng,
        cursor: currentState.meta.nextCursor,
      ));

      result.when(
        success: (data) => emit(ShopLoaded(
          shops: [...currentState.shops, ...data.data],
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

  Future<void> _onRefreshShops(
    RefreshShopsEvent event,
    Emitter<ShopState> emit,
  ) async {
    final result = await getShopsByLocation(GetShopsByLocationParams(
      limit: event.limit,
      lat: event.lat,
      lng: event.lng,
    ));

    result.when(
      success: (data) => emit(ShopLoaded(
        shops: data.data,
        meta: data.meta,
        isLoadingMore: false,
      )),
      failure: (failure) => emit(ShopError(failure.message)),
    );
  }
}