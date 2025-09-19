// Package imports:
import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

class ShopsRequested extends ShopEvent {
  const ShopsRequested({
    required this.lat,
    required this.lng,
    this.categoryId,
  });

  final double lat;
  final double lng;
  final String? categoryId;

  @override
  List<Object?> get props => [lat, lng, categoryId];
}

class ShopsNextPageRequested extends ShopEvent {
  const ShopsNextPageRequested();
}

class ShopsRefresh extends ShopEvent {
  const ShopsRefresh({
    required this.lat,
    required this.lng,
    this.categoryId,
  });

  final double lat;
  final double lng;
  final String? categoryId;

  @override
  List<Object?> get props => [lat, lng, categoryId];
}
