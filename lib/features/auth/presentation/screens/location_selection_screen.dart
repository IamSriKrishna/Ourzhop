// Flutter imports:
import 'package:customer_app/core/services/auth_preference_service.dart';
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

class LocationSelectionScreen extends StatefulWidget {
  const LocationSelectionScreen({super.key});

  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingLocation = false;
  String? _currentLocation;
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: appColors.backgroundGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // App Bar
                  _buildAppBar(context),
                  
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),

                          // Subtitle Section
                          _buildSubtitleSection(context),

                          const SizedBox(height: 24.0),

                          // Search Input Section
                          _buildSearchInputSection(context),

                          const SizedBox(height: 16.0),

                          // Current Location Option
                          _buildCurrentLocationSection(context),

                          // Error Display
                          if (_errorMessage != null) _buildErrorSection(context),

                          // Spacer to push button to bottom
                          const Spacer(),

                          // Continue Button
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
        // Loading overlay
        if (_isLoadingLocation)
          ProgressDialog(
            title: "Getting your location...",
            isProgressed: true,
          ),
      ],
    );
  }

  /// Builds the app bar
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _navigateBack(context),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            "Select location",
            style: AppTypography.getAppBarTitle(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the subtitle section
  Widget _buildSubtitleSection(BuildContext context) {
    return Text(
      "Use current location or search your own location",
      style: AppTypography.getBodyText(context).copyWith(
        color: Colors.grey[600],
        fontSize: 14,
      ),
    );
  }

  /// Builds the search input section
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
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 18.0,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _errorMessage = null;
          });
        },
      ),
    );
  }

  /// Builds the current location section
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
    final canContinue = _currentLocation != null || _searchController.text.isNotEmpty;

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
    });

    try {
      // Check and request permission
      final permission = await _checkAndRequestLocationPermission();
      if (!permission) {
        setState(() {
          _errorMessage = "Location permission is required to get your current location";
          _isLoadingLocation = false;
        });
        return;
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = "Location services are disabled. Please enable them in settings.";
          _isLoadingLocation = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final cityName = placemark.locality ?? placemark.subAdministrativeArea ?? 'Unknown Location';
        
        setState(() {
          _currentLocation = cityName;
          _isLoadingLocation = false;
        });
      } else {
        setState(() {
          _errorMessage = "Could not determine your location. Please try again.";
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to get your location. Please check your internet connection and try again.";
        _isLoadingLocation = false;
      });
      print('Location error: $e');
    }
  }

  /// Checks and requests location permission
  Future<bool> _checkAndRequestLocationPermission() async {
    // Check current permission status
    PermissionStatus permission = await Permission.location.status;
    
    if (permission.isDenied) {
      // Request permission
      permission = await Permission.location.request();
    }
    
    if (permission.isPermanentlyDenied) {
      // Show dialog to open settings
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
    final selectedLocation = _currentLocation ?? _searchController.text.trim();
    
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

  /// Navigates back
  void _navigateBack(BuildContext context) {
    try {
      context.pop();
    } catch (e) {
      Navigator.of(context).pop();
    }
  }
}