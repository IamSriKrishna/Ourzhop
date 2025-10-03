import 'package:customer_app/common/dialog/logout_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
class LocationNavigationHandler {
  static void handleContinue(BuildContext context) {
    final cubit = context.read<LocationSelectionCubit>();
    final selectedLocation = cubit.finalLocation;

    if (selectedLocation == null || selectedLocation.isEmpty) {
      return;
    }

    _navigateToHome(context, selectedLocation);
  }

  static void _navigateToHome(BuildContext context, String location) {
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

  static Future<void> handleBackNavigation(BuildContext context) async {
    try {
      final shouldLogout = await LogoutConfirmationDialog.show(context);

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
}
