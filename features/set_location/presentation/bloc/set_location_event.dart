// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';

abstract class SetLocationEvent extends Equatable {
  const SetLocationEvent();

  @override
  List<Object?> get props => [];
}

/// Event fired when search input changes
class SearchInputChanged extends SetLocationEvent {
  const SearchInputChanged(this.searchText);

  final String searchText;

  @override
  List<Object?> get props => [searchText];
}

/// Event fired when API search should be performed
class SearchSetLocationRequested extends SetLocationEvent {
  const SearchSetLocationRequested(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

/// Event fired when a location is selected from results
class LocationSelected extends SetLocationEvent {
  const LocationSelected(this.location);

  final SetLocationModel location;

  @override
  List<Object?> get props => [location];
}

/// Event fired to clear search results and reset state
class ClearSetLocationEvent extends SetLocationEvent {
  const ClearSetLocationEvent();
}

/// Event fired to show validation errors
class ShowSearchValidationError extends SetLocationEvent {
  const ShowSearchValidationError();
}

/// Event fired to hide validation errors
class HideSearchValidationError extends SetLocationEvent {
  const HideSearchValidationError();
}
