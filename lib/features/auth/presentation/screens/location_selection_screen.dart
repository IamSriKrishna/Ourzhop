
import 'package:customer_app/features/auth/presentation/bloc/location_selection_cubit.dart';
import 'package:customer_app/features/auth/presentation/widgets/continue_button.dart';
import 'package:customer_app/features/auth/presentation/widgets/current_location_card.dart';
import 'package:customer_app/features/auth/presentation/widgets/error_display_card.dart';
import 'package:customer_app/features/auth/presentation/widgets/location_search_input.dart';
import 'package:customer_app/features/auth/presentation/widgets/location_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/auth/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/location/location_event.dart';
import 'package:customer_app/service_locator.dart';

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationSelectionCubit()),
        BlocProvider.value(value: serviceLocator<LocationSearchBloc>()),
      ],
      child: const _LocationSelectionView(),
    );
  }
}

class _LocationSelectionView extends StatelessWidget {
  const _LocationSelectionView();

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
      child: BlocListener<LocationSelectionCubit, LocationSelectionState>(
        listener: _handleStateChanges,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0),
                              _buildHeader(context),
                              const SizedBox(height: 24.0),
                              _buildSearchSection(context),
                              const SizedBox(height: 16.0),
                              const CurrentLocationCard(),
                              _buildErrorSection(),
                              const Spacer(),
                              ContinueButton(
                                onPressed: () => _onContinuePressed(context),
                              ),
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
            _buildLoadingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
        LocationSearchInput(
          onLocationSelected: (location) {
            context.read<LocationSearchBloc>().add(ClearLocationSearchEvent());
          },
        ),
        LocationSearchResults(
          onLocationSelected: (location) {
            context
                .read<LocationSelectionCubit>()
                .setSelectedSearchLocation(location.description);
            context.read<LocationSearchBloc>().add(ClearLocationSearchEvent());
          },
        ),
      ],
    );
  }

  Widget _buildErrorSection() {
    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        if (state is LocationSelectionError) {
          return ErrorDisplayCard(message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingOverlay() {
    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        if (state is LocationSelectionLoading) {
          return const ProgressDialog(
            title: "Getting your location...",
            isProgressed: true,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _handleStateChanges(BuildContext context, LocationSelectionState state) {
    if (state is LocationSelectionPermissionDenied) {
      _showPermissionDialog(context);
    }
  }

  void _showPermissionDialog(BuildContext context) {
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

  void _onContinuePressed(BuildContext context) {
    final cubit = context.read<LocationSelectionCubit>();
    final selectedLocation = cubit.finalLocation;

    if (selectedLocation == null || selectedLocation.isEmpty) {
      // This shouldn't happen due to button state management
      return;
    }

    _navigateToNextScreen(context, selectedLocation);
  }

  void _navigateToNextScreen(BuildContext context, String location) {
    try {
      AuthPreferenceService().saveUserLocation(location);
      context.pushReplacement(AppRoutes.home);
    } catch (e) {
      AppErrorDisplay.showDialog(
        context,
        'Navigation failed. Please try again.',
        title: 'Error',
        buttonLabel: 'OK',
        onPressed: () {},
      );
    }
  }

  Future<void> _handleBackNavigation(BuildContext context) async {
    try {
      final shouldLogout = await _showLogoutConfirmationDialog(context);

      if (shouldLogout) {
        await AuthPreferenceService().logout();
        if (context.mounted) {
          context.pushReplacement(AppRoutes.login);
        }
      }
    } catch (e) {
      if (context.mounted) {
        context.pushReplacement(AppRoutes.login);
      }
    }
  }

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
        ) ??
        false;
  }
}