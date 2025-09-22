import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

// States
abstract class LocationSelectionState extends Equatable {
  const LocationSelectionState();

  @override
  List<Object?> get props => [];
}

class LocationSelectionInitial extends LocationSelectionState {}

class LocationSelectionLoading extends LocationSelectionState {}

class LocationSelectionCurrentLocationSet extends LocationSelectionState {
  final String location;

  const LocationSelectionCurrentLocationSet(this.location);

  @override
  List<Object> get props => [location];
}

class LocationSelectionManualLocationSet extends LocationSelectionState {
  final String location;

  const LocationSelectionManualLocationSet(this.location);

  @override
  List<Object> get props => [location];
}

class LocationSelectionError extends LocationSelectionState {
  final String message;

  const LocationSelectionError(this.message);

  @override
  List<Object> get props => [message];
}

class LocationSelectionPermissionDenied extends LocationSelectionState {}

// Cubit
class LocationSelectionCubit extends Cubit<LocationSelectionState> {
  LocationSelectionCubit() : super(LocationSelectionInitial());

  String? _currentLocation;
  String? _selectedSearchLocation;
  String? _manualLocation;

  String? get currentLocation => _currentLocation;
  String? get selectedSearchLocation => _selectedSearchLocation;
  String? get manualLocation => _manualLocation;

  bool get canContinue => 
      _currentLocation != null || 
      _selectedSearchLocation != null || 
      (_manualLocation != null && _manualLocation!.isNotEmpty);

  String? get finalLocation {
    if (_selectedSearchLocation != null) return _selectedSearchLocation;
    if (_currentLocation != null) return _currentLocation;
    if (_manualLocation != null && _manualLocation!.isNotEmpty) {
      return _manualLocation;
    }
    return null;
  }

  void setManualLocation(String location) {
    _manualLocation = location;
    if (location.isEmpty) {
      emit(LocationSelectionInitial());
    } else {
      emit(LocationSelectionManualLocationSet(location));
    }
  }

  void setSelectedSearchLocation(String location) {
    _selectedSearchLocation = location;
    _clearOtherLocations(keepSearch: true);
    emit(LocationSelectionManualLocationSet(location));
  }

  void clearSelection() {
    _currentLocation = null;
    _selectedSearchLocation = null;
    _manualLocation = null;
    emit(LocationSelectionInitial());
  }

  void clearError() {
    if (state is LocationSelectionError) {
      emit(LocationSelectionInitial());
    }
  }

  Future<void> getCurrentLocation() async {
    emit(LocationSelectionLoading());

    try {
      // Check and request permission
      final hasPermission = await _checkAndRequestLocationPermission();
      if (!hasPermission) {
        emit(LocationSelectionPermissionDenied());
        return;
      }

      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const LocationSelectionError(
          "Location services are disabled. Please enable them in settings."
        ));
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final formattedLocation = _formatLocationFromPlacemark(placemarks.first);
        if (formattedLocation != null) {
          _currentLocation = formattedLocation;
          _clearOtherLocations(keepCurrent: true);
          emit(LocationSelectionCurrentLocationSet(formattedLocation));
        } else {
          emit(const LocationSelectionError(
            "Could not determine your location details. Please try again."
          ));
        }
      } else {
        emit(const LocationSelectionError(
          "Could not determine your location. Please try again."
        ));
      }
    } catch (e) {
      emit(const LocationSelectionError(
        "Failed to get your location. Please check your internet connection and try again."
      ));
    }
  }

  Future<bool> _checkAndRequestLocationPermission() async {
    var permission = await Permission.location.status;

    if (permission.isDenied) {
      permission = await Permission.location.request();
    }

    return permission.isGranted;
  }

  String? _formatLocationFromPlacemark(Placemark placemark) {
    final areaName = placemark.subLocality ?? 
                    placemark.thoroughfare ?? 
                    placemark.name;
    
    final cityName = placemark.locality ?? 
                    placemark.subAdministrativeArea;
    
    final countryName = placemark.country;
    
    final locationParts = <String>[];
    
    if (areaName?.isNotEmpty == true) {
      locationParts.add(areaName!.toLowerCase());
    }
    
    if (cityName?.isNotEmpty == true) {
      locationParts.add(cityName!.toLowerCase());
    }
    
    if (countryName?.isNotEmpty == true) {
      locationParts.add(countryName!.toLowerCase());
    }
    
    return locationParts.isNotEmpty ? locationParts.join(',') : null;
  }

  void _clearOtherLocations({
    bool keepCurrent = false,
    bool keepSearch = false,
    bool keepManual = false,
  }) {
    if (!keepCurrent) _currentLocation = null;
    if (!keepSearch) _selectedSearchLocation = null;
    if (!keepManual) _manualLocation = null;
  }
}
