// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object?> get props => [];
}

class ShopsInitial extends ShopState {
  const ShopsInitial();
}

class ShopsLoading extends ShopState {
  const ShopsLoading([this.shops = const []]);

  final List<ShopEntity> shops;

  @override
  List<Object?> get props => [shops];
}

class ShopsSuccess extends ShopState {
  const ShopsSuccess(this.shops, this.hasMore);

  final List<ShopEntity> shops;
  final bool hasMore;

  @override
  List<Object?> get props => [shops, hasMore];
}

class ShopsFailure extends ShopState {
  const ShopsFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
