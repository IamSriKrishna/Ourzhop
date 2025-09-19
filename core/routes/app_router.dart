// lib/router/app_router.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:customer_app/core/routes/main_shell.dart';
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/core/utils/app_logger.dart';
import 'package:customer_app/features/account_setup/presentation/bloc/account_setup_bloc.dart';
import 'package:customer_app/features/account_setup/presentation/screens/account_setup_screen.dart';
import 'package:customer_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:customer_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:customer_app/features/category/presentation/screens/category_screen.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/presentation/screens/home_content_wrapper.dart';
import 'package:customer_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:customer_app/features/login/presentation/screens/login_screen.dart';
import 'package:customer_app/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:customer_app/features/otp/presentation/screens/otp_screen.dart';
import 'package:customer_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_bloc.dart';
import 'package:customer_app/features/set_location/presentation/screens/set_location_screen.dart';
import 'package:customer_app/service_locator.dart';

// Project imports

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _goRouter;

  static final GoRouter _goRouter = GoRouter(
    initialLocation: AppRoutes.home,
    navigatorKey: rootNavigatorKey,
    routes: _getRoutes(),
    redirect: _redirectLogic,
  );

  static List<RouteBase> _getRoutes() => [
        ShellRoute(
          builder: (context, state, child) => BlocProvider(
            create: (context) => BottomNavigationCubit(),
            child: MainShell(child: child),
          ),
          routes: [
            // Home Tab
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => BlocProvider(
                create: (_) => serviceLocator<HomeBloc>(),
                child: const HomeContentWrapper(),
              ),
            ),

            // Category Tab
            GoRoute(
              path: AppRoutes.categoryScreen,
              name: AppRoutes.categoryScreen,
              builder: (context, state) => BlocProvider(
                create: (_) => serviceLocator<CategoryBloc>(),
                child: const CategoryScreen(),
              ),
            ),

            // Cart Tab
            GoRoute(
              path: AppRoutes.cartScreen,
              name: AppRoutes.cartScreen,
              builder: (context, state) => CartContent(),
            ),
          ],
        ),
        // Login Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => BlocProvider(
            create: (context) => serviceLocator<LoginBloc>(),
            child: LoginScreen(
              initialPhoneNumber: state.extra as String?,
            ),
          ),
        ),

        // otp  Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.otp,
          name: 'otp',
          builder: (context, state) => BlocProvider(
            create: (context) => serviceLocator<OtpBloc>(),
            child: OtpScreen(
              mobileNumber: state.extra as String,
            ),
          ),
        ),

        // account setup  Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.accountSetup,
          name: 'account-setup',
          builder: (context, state) => BlocProvider(
            create: (context) => serviceLocator<AccountSetupBloc>(),
            child: AccountSetupScreen(),
          ),
        ),

        GoRoute(
          path: AppRoutes.locationSelection,
          name: 'location-selection',
          builder: (context, state) => BlocProvider(
            create: (context) => serviceLocator<SetLocationBloc>(),
            child: SetLocationScreen(),
          ),
        ),

        // Profile Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.profileScreen,
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ];
  static Future<String?> _redirectLogic(
      BuildContext context, GoRouterState state) async {
    final logger = AppLogger();
    final authService = UserPreferenceService();

    // Define constant paths
    const String loginPath = AppRoutes.login;
    const String verifyOtpPath = AppRoutes.otp;
    const String accountSetupPath = AppRoutes.accountSetup;
    const String locationSelectionPath = AppRoutes.locationSelection;
    const String homePath = AppRoutes.home;

    final currentPath = state.uri.toString();

    try {
      final bool isLoggedIn = await authService.isLoggedIn();
      final bool isUserNew = await authService.isUserNew();
      final bool hasSelectedLocation = await authService.isLocationAvailable();

      logger.info('Redirect check - '
          'LoggedIn: $isLoggedIn, '
          'IsNew: $isUserNew, '
          'HasLocation: $hasSelectedLocation, '
          'CurrentPath: $currentPath');

      // If not logged in, redirect to login (except for OTP verification)
      if (!isLoggedIn) {
        if (currentPath != verifyOtpPath && currentPath != loginPath) {
          logger.info('User not logged in. Redirecting to Sign-in page.');
          return loginPath;
        }
        return null; // Allow login and OTP screens
      }

      // User is logged in - check the flow
      if (isUserNew) {
        // New user must complete account setup first
        if (currentPath != accountSetupPath && currentPath != verifyOtpPath) {
          logger.info('New user detected. Redirecting to Account Setup page.');
          return accountSetupPath;
        }
        return null; // Allow account setup screen
      }

      // Existing user but hasn't selected location
      if (!hasSelectedLocation) {
        if (currentPath != locationSelectionPath &&
            currentPath != accountSetupPath &&
            currentPath != verifyOtpPath) {
          logger.info(
              'User needs to select location. Redirecting to Location Selection page.');
          return locationSelectionPath;
        }
        return null; // Allow location selection screen
      }

      // User is logged in, not new, and has selected location
      // Prevent going back to auth screens
      if (currentPath == loginPath ||
          currentPath == verifyOtpPath ||
          currentPath == accountSetupPath ||
          currentPath == locationSelectionPath) {
        logger.info('User already authenticated. Redirecting to Home.');
        return homePath;
      }

      // Allow access to the requested route
      logger.info('Proceeding to requested route: $currentPath');
      return null;
    } catch (e, stackTrace) {
      logger.error('Redirect logic failed: $e', stackTrace);
      return null;
    }
  }
}
