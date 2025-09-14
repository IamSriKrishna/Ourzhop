// ====================
// Updated Location Selection Screen with Search Integration
// ====================
// File: lib/features/location/presentation/screens/location_selection_screen.dart

// Flutter imports:
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/location_model.dart';
import 'package:customer_app/features/auth/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/location/location_event.dart';
import 'package:customer_app/features/auth/presentation/bloc/location/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/service_locator.dart';

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingLocation = false;
  String? _currentLocation;
  LocationModel? _selectedLocation;
  String? _errorMessage;
  
  late LocationSearchBloc _locationSearchBloc;

  @override
  void initState() {
    super.initState();
    _locationSearchBloc = serviceLocator<LocationSearchBloc>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _locationSearchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return PopScope(
      canPop: false, 
      onPopInvoked: (didPop) async {
        if (!didPop) {
          await _handleBackNavigation(context);
        }
      },
      child: BlocProvider.value(
        value: _locationSearchBloc,
        child: Stack(
          children: [
            Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: appColors.backgroundGradient,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Content
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0),

                              _buildSubtitleSection(context),

                              const SizedBox(height: 24.0),

                              _buildSearchSection(context),

                              const SizedBox(height: 16.0),

                              _buildCurrentLocationSection(context),

                              if (_errorMessage != null)
                                _buildErrorSection(context),

                              const Spacer(),

                              _buildContinueButton(context),

                              const SizedBox(height: 24.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoadingLocation)
              ProgressDialog(
                title: "Getting your location...",
                isProgressed: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          "Select location",
          style: AppTypography.getAppBarTitle(context).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Use current location or search your own\nlocation",
          style: AppTypography.getBodyText(context).copyWith(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection(BuildContext context) {
    return Column(
      children: [
        _buildSearchInputSection(context),
        
        BlocBuilder<LocationSearchBloc, LocationSearchState>(
          builder: (context, state) {
            if (state is LocationSearchLoading) {
              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                height: 60,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is LocationSearchSuccess) {
              return _buildSearchResults(context, state.locations);
            } else if (state is LocationSearchError) {
              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        state.message,
                        style: AppTypography.getBodyText(context).copyWith(
                          color: Colors.red[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LocationSearchEmpty) {
              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_off, color: Colors.grey[500], size: 20),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        "No locations found for your search",
                        style: AppTypography.getBodyText(context).copyWith(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildSearchInputSection(BuildContext context) {
    return Container(
      height: 56.0,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search for area, street...",
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500],
            size: 24,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: () {
                    _searchController.clear();
                    _locationSearchBloc.add(ClearLocationSearchEvent());
                    setState(() {
                      _selectedLocation = null;
                      _errorMessage = null;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 18.0,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _errorMessage = null;
            _selectedLocation = null;
          });
          
          if (value.trim().isNotEmpty && value.length >= 3) {
            _locationSearchBloc.add(SearchLocationEvent(value.trim()));
          } else {
            _locationSearchBloc.add(ClearLocationSearchEvent());
          }
        },
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, List<LocationModel> locations) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return ListTile(
            leading: const Icon(
              Icons.location_on,
              color: Colors.grey,
              size: 20,
            ),
            title: Text(
              location.mainText,
              style: AppTypography.getBodyText(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              location.secondaryText,
              style: AppTypography.getBodyText(context).copyWith(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              setState(() {
                _selectedLocation = location;
                _searchController.text = location.mainText;
                _errorMessage = null;
              });
              _locationSearchBloc.add(ClearLocationSearchEvent());
            },
          );
        },
      ),
    );
  }

  Widget _buildCurrentLocationSection(BuildContext context) {
    final appColors = context.appColors;

    return GestureDetector(
      onTap: _getCurrentLocation,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: _currentLocation != null
                ? appColors.primary.withOpacity(0.3)
                : Colors.grey[200]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: appColors.primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentLocation ?? "Use current location",
                    style: AppTypography.getBodyText(context).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    _currentLocation != null
                        ? "Location detected"
                        : "Need to give location permission",
                    style: AppTypography.getBodyText(context).copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (_currentLocation != null)
              Icon(
                Icons.check_circle,
                color: appColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the error section
  Widget _buildErrorSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[600],
            size: 20,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _errorMessage!,
              style: AppTypography.getBodyText(context).copyWith(
                color: Colors.red[700],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the continue button
  Widget _buildContinueButton(BuildContext context) {
    final appColors = context.appColors;
    final canContinue = _currentLocation != null || 
                       _selectedLocation != null || 
                       _searchController.text.isNotEmpty;

    return Container(
      width: double.infinity,
      height: 58.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: canContinue
            ? LinearGradient(
                colors: [
                  appColors.primary,
                  appColors.primary.withOpacity(0.8),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: canContinue ? null : Colors.grey[300],
      ),
      child: ElevatedButton(
        onPressed: canContinue ? () => _onContinuePressed(context) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 0,
        ),
        child: Text(
          "Continue",
          style: AppTypography.getButtonText(context).copyWith(
            color: canContinue ? Colors.white : Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Gets the current location
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
      _errorMessage = null;
      _selectedLocation = null;
      _searchController.clear();
    });
    _locationSearchBloc.add(ClearLocationSearchEvent());

    try {
      // Check and request permission
      final permission = await _checkAndRequestLocationPermission();
      if (!permission) {
        setState(() {
          _errorMessage =
              "Location permission is required to get your current location";
          _isLoadingLocation = false;
        });
        return;
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage =
              "Location services are disabled. Please enable them in settings.";
          _isLoadingLocation = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        
        String? areaName = placemark.subLocality ?? 
                          placemark.thoroughfare ?? 
                          placemark.name;
        
        String? cityName = placemark.locality ?? 
                          placemark.subAdministrativeArea;
        
        String? countryName = placemark.country;
        
        List<String> locationParts = [];
        
        if (areaName != null && areaName.isNotEmpty) {
          locationParts.add(areaName.toLowerCase());
        }
        
        if (cityName != null && cityName.isNotEmpty) {
          locationParts.add(cityName.toLowerCase());
        }
        
        if (countryName != null && countryName.isNotEmpty) {
          locationParts.add(countryName.toLowerCase());
        }
        
        if (locationParts.isNotEmpty) {
          String formattedLocation = locationParts.join(',');
          
          setState(() {
            _currentLocation = formattedLocation;
            _isLoadingLocation = false;
          });
          
          print('Formatted Location: $formattedLocation');
        } else {
          setState(() {
            _errorMessage =
                "Could not determine your location details. Please try again.";
            _isLoadingLocation = false;
          });
        }
      } else {
        setState(() {
          _errorMessage =
              "Could not determine your location. Please try again.";
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            "Failed to get your location. Please check your internet connection and try again.";
        _isLoadingLocation = false;
      });
      print('Location error: $e');
    }
  }

  /// Checks and requests location permission
  Future<bool> _checkAndRequestLocationPermission() async {
    PermissionStatus permission = await Permission.location.status;

    if (permission.isDenied) {
      permission = await Permission.location.request();
    }

    if (permission.isPermanentlyDenied) {
      _showPermissionDialog();
      return false;
    }

    return permission.isGranted;
  }

  /// Shows permission dialog
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs location permission to get your current location. Please enable it in app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Handles continue button press
  void _onContinuePressed(BuildContext context) {
    String selectedLocation;
    
    if (_selectedLocation != null) {
      // Use the selected search result
      selectedLocation = _selectedLocation!.description;
    } else if (_currentLocation != null) {
      // Use current location
      selectedLocation = _currentLocation!;
    } else {
      // Use manual input
      selectedLocation = _searchController.text.trim();
    }

    if (selectedLocation.isEmpty) {
      setState(() {
        _errorMessage = "Please select a location to continue";
      });
      return;
    }

    // Navigate to next screen with selected location
    _navigateToNextScreen(context, selectedLocation);
  }

  /// Navigates to the next screen
  void _navigateToNextScreen(BuildContext context, String location) {
    try {
      AuthPreferenceService().saveUserLocation(location);

      context.pushReplacement(AppRoutes.home);
    } catch (e) {
      print('Navigation error: $e');
      AppErrorDisplay.showDialog(
        context,
        'Navigation failed. Please try again.',
        title: 'Error',
        buttonLabel: 'OK',
        onPressed: () {},
      );
    }
  }

  /// Handles back navigation - logs out user and redirects to login
  Future<void> _handleBackNavigation(BuildContext context) async {
    try {
      // Show confirmation dialog
      final shouldLogout = await _showLogoutConfirmationDialog(context);
      
      if (shouldLogout) {
        // Clear user session/logout
        await AuthPreferenceService().logout();
        
        // Navigate to login screen
        if (context.mounted) {
          context.pushReplacement(AppRoutes.login);
        }
      }
    } catch (e) {
      print('Back navigation error: $e');
      // Fallback navigation
      if (context.mounted) {
        context.pushReplacement(AppRoutes.login);
      }
    }
  }

  /// Shows logout confirmation dialog
  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Going back will log you out. Are you sure you want to continue?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }
}