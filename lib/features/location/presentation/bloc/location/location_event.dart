
abstract class LocationSearchEvent {}

class SearchLocationEvent extends LocationSearchEvent {
  final String query;
  SearchLocationEvent(this.query);
}

class ClearLocationSearchEvent extends LocationSearchEvent {}

