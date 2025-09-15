
part of 'shop_bloc.dart';

@immutable
sealed class ShopEvent {}

@immutable
class GetShopsByLocationEvent extends ShopEvent {
  final int? limit;
  final double lat;
  final double lng;
  final String? cursor;

  GetShopsByLocationEvent({
    this.limit,
    required this.lat,
    required this.lng,
    this.cursor,
  });
}

@immutable
class LoadMoreShopsEvent extends ShopEvent {
  final int? limit;
  final double lat;
  final double lng;

  LoadMoreShopsEvent({
    this.limit,
    required this.lat,
    required this.lng,
  });
}

@immutable
class RefreshShopsEvent extends ShopEvent {
  final int? limit;
  final double lat;
  final double lng;

  RefreshShopsEvent({
    this.limit,
    required this.lat,
    required this.lng,
  });
}