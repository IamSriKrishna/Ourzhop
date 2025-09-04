// lib/router/app_router.dart

// Flutter imports:
import 'package:customer_app/features/auth/presentation/screens/register_screen.dart';
import 'package:customer_app/features/auth/presentation/screens/set_password_screen.dart';
import 'package:customer_app/features/auth/presentation/screens/location_selection_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/core/utils/app_logger.dart';
import 'package:customer_app/features/auth/presentation/screens/account_setup_screen.dart';
import 'package:customer_app/features/auth/presentation/screens/login_screen.dart';
import 'package:customer_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:customer_app/features/home/presentation/screens/home_content.dart';
import 'package:customer_app/features/home/presentation/screens/home_screen.dart';
import 'package:customer_app/features/pages/page.dart';

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
            child: HomeScreen(screen: child),
          ),
          routes: [
            // Home Tab
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => HomeContent(),
              routes: [
                GoRoute(
                  path: AppRoutes.details,
                  name: 'details',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return DetailsScreen(id: id);
                  },
                ),
              ],
            ),
            // Profile Tab
            GoRoute(
              path: AppRoutes.profile,
              name: 'profile',
              builder: (context, state) => ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'settings',
                  name: 'settings',
                  builder: (context, state) => SettingsScreen(),
                ),
              ],
            ),
          ],
        ),
        // Login Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => LoginScreen(),
        ),

        GoRoute(
          path: AppRoutes.register,
          name: 'register',
          builder: (context, state) => RegisterScreen(),
        ),

        // otp  Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.otp,
          name: 'otp',
          builder: (context, state) {
            // Handle both old and new navigation patterns
            if (state.extra is String) {
              // Old pattern - just mobile number
              return OtpScreen(mobileNumber: state.extra as String);
            } else if (state.extra is Map<String, dynamic>) {
              // New pattern - with source tracking
              final extraData = state.extra as Map<String, dynamic>;
              return OtpScreen(
                mobileNumber: extraData['mobileNumber'] as String,
                sourceScreen: extraData['sourceScreen'] as String?,
              );
            } else {
              // Fallback
              return OtpScreen(mobileNumber: '');
            }
          },
        ),

        // account setup  Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.accountSetup,
          name: 'account-setup',
          builder: (context, state) => AccountSetupScreen(),
        ),

        GoRoute(
          path: AppRoutes.setPassword,
          name: 'set-password',
          builder: (context, state) => SetPasswordScreen(),
        ),

        // Location Selection Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.locationSelection,
          name: 'location-selection',
          builder: (context, state) => LocationSelectionScreen(),
        ),
      ];

  /// Determines whether to redirect the user based on authentication and user status.
  /// Returns a string URI to redirect to, or null to proceed to the requested route.
  static Future<String?> _redirectLogic(
      BuildContext context, GoRouterState state) async {
    final logger = AppLogger();
    final authService = AuthPreferenceService();

    // Define constant paths
    const String loginPath = AppRoutes.login;
    const String registerPath = AppRoutes.register;
    const String verifyOtpPath = AppRoutes.otp;
    const String accountSetupPath = AppRoutes.accountSetup;
    const String setPasswordPath = AppRoutes.setPassword;
    const String locationSelectionPath = AppRoutes.locationSelection;

    final currentPath = state.uri.toString();

    try {
      // Fetch login status and user data separately with explicit typing
      final bool isLoggedIn = await authService.isLoggedIn();
      final bool isUserNew = await authService.isUserNew();

      // Define public routes that don't require authentication
      // Include all auth-related routes that should be accessible during auth flow
      final publicRoutes = [loginPath, registerPath, verifyOtpPath, setPasswordPath, accountSetupPath, locationSelectionPath];
      final isPublicRoute = publicRoutes.contains(currentPath);

      // If the user is not logged in and is not on a public route, redirect to login
      if (!isLoggedIn && !isPublicRoute) {
        logger.info('User not logged in. Redirecting to Sign-in page.');
        return loginPath;
      }

      // If user is logged in and not new, redirect away from auth pages
      if (isLoggedIn && isUserNew != true) {
        final authPages = [loginPath, registerPath, setPasswordPath, accountSetupPath, locationSelectionPath];
        if (authPages.contains(currentPath)) {
          logger
              .info('Logged in user accessing auth page. Redirecting to home.');
          return AppRoutes.home;
        }
      }

      // Allow access to the requested route - no automatic redirects for new users
      // Let the OTP screen handle the navigation based on source
      logger.info('Proceeding to requested route: $currentPath');
      return null;
    } catch (e, stackTrace) {
      // Handle potential errors gracefully
      logger.error('Redirect logic failed: $e', stackTrace);
      return null;
    }
  }
}