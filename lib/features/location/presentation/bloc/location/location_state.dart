
import 'package:customer_app/features/location/data/model/location_model.dart';

abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchLoading extends LocationSearchState {}

class LocationSearchSuccess extends LocationSearchState {
  final List<LocationModel> locations;
  LocationSearchSuccess(this.locations);
}

class LocationSearchError extends LocationSearchState {
  final String message;
  LocationSearchError(this.message);
}

class LocationSearchEmpty extends LocationSearchState {}