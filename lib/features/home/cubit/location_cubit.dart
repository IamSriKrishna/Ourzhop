// location_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/home/widgets/location_helper.dart';

class LocationState {
  final double? lat;
  final double? lng;
  final bool isLoading;
  final String? error;

  const LocationState({
    this.lat,
    this.lng,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    double? lat,
    double? lng,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(isLoading: true, error: null));
    
    try {
      final coordinates = await LocationHelper.getCoordinates();
      if (coordinates != null) {
        emit(state.copyWith(
          lat: coordinates.lat,
          lng: coordinates.lng,
          isLoading: false,
        ));
      } else {
        // Fallback to default coordinates
        emit(state.copyWith(
          lat: 12.8738,
          lng: 80.0784,
          isLoading: false,
        ));
      }
    } catch (e) {
      // Fallback to default coordinates on error
      emit(state.copyWith(
        lat: 12.8738,
        lng: 80.0784,
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}