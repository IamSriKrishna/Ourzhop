part of 'home_bloc.dart';

@immutable
sealed class CategoryEvent {}

@immutable
class GetCategoriesEvent extends CategoryEvent {
  final int? limit;
  final String? cursor;

  GetCategoriesEvent({
    this.limit,
    this.cursor,
  });
}

@immutable
class LoadMoreCategoriesEvent extends CategoryEvent {
  final int? limit;

  LoadMoreCategoriesEvent({
    this.limit,
  });
}

@immutable
class RefreshCategoriesEvent extends CategoryEvent {
  final int? limit;

  RefreshCategoriesEvent({
    this.limit,
  });
}
