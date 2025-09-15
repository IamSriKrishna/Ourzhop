
part of 'shop_bloc.dart';

@immutable
sealed class ShopState {}

@immutable
class ShopInitial extends ShopState {
  ShopInitial();
}

@immutable
class ShopLoading extends ShopState {
  ShopLoading();
}

@immutable
class ShopLoaded extends ShopState {
  final List<ShopModel> shops;
  final MetaModel meta;
  final bool isLoadingMore;
  final String? error;

  ShopLoaded({
    required this.shops,
    required this.meta,
    required this.isLoadingMore,
    this.error,
  });

  ShopLoaded copyWith({
    List<ShopModel>? shops,
    MetaModel? meta,
    bool? isLoadingMore,
    String? error,
  }) {
    return ShopLoaded(
      shops: shops ?? this.shops,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}

@immutable
class ShopError extends ShopState {
  final String message;

  ShopError(this.message);
}
