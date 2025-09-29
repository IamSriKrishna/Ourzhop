// lib/router/app_router.dart

// Flutter imports:
import 'package:customer_app/features/location/presentation/screen/location_selection_screen.dart';
import 'package:customer_app/features/cart/presentation/screen/cart_screen.dart';
import 'package:customer_app/features/category/presentation/screens/category_screen.dart';
import 'package:customer_app/features/store/presentation/screens/grocery_store_screen.dart';
import 'package:customer_app/features/home/presentation/screens/product_detail_screen.dart';
import 'package:customer_app/features/home/presentation/screens/search_screen.dart';
import 'package:customer_app/features/store/presentation/screens/store_screen.dart';
import 'package:customer_app/features/store/presentation/screens/store_screen_list.dart';
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
            child: HomeScreen(screen: child),
          ),
          routes: [
            //cart screen

            // Home Tab
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => HomeContent(),
              routes: [
                // GoRoute(
                //   path: AppRoutes.details,
                //   name: 'details',
                //   builder: (context, state) {
                //     final id = state.pathParameters['id']!;
                //     return DetailsScreen(id: id);
                //   },
                // ),
                 GoRoute(
                  parentNavigatorKey: AppRouter.rootNavigatorKey,
                  path: AppRoutes.cartScreen,
                  name: AppRoutes.cartScreen,
                  builder: (context, state) => CartScreen(),
                  routes: [],
                ),
                GoRoute(
                    parentNavigatorKey: AppRouter.rootNavigatorKey,
                    path: AppRoutes.storeScreen,
                    name: AppRoutes.storeScreen,
                    builder: (context, state) {
                      return StoreScreen();
                    },
                    routes: [
                      GoRoute(
                          parentNavigatorKey: AppRouter.rootNavigatorKey,
                          path: AppRoutes.groceryStoreScreen,
                          name: AppRoutes.groceryStoreScreen,
                          builder: (context, state) {
                            return GroceryHomePage();
                          },
                          routes: [
                            GoRoute(
                                parentNavigatorKey: AppRouter.rootNavigatorKey,
                                path: AppRoutes.productScreen,
                                name: AppRoutes.productScreen,
                                builder: (context, state) {
                                  return ProductDetailScreen();
                                })
                          ]),
                    ]),
                //search screen
                GoRoute(
                    path: AppRoutes.searchScreen,
                    parentNavigatorKey: AppRouter.rootNavigatorKey,
                    name: AppRoutes.searchScreen,
                    builder: (context, state) => SearchScreen(
                          isHome: true,
                        ),
                    routes: [
                      //store screen
                      GoRoute(
                        path: AppRoutes.storeListScreen,
                        parentNavigatorKey: AppRouter.rootNavigatorKey,
                        name: AppRoutes.storeListScreen,
                        builder: (context, state) => StoreScreenList(),
                      ),
                    ]),
              ],
            ),

            // Profile Tab
            GoRoute(
              path: AppRoutes.categoryScreen,
              name: AppRoutes.categoryScreen,
              builder: (context, state) => CategoriesScreen(),
              routes: [
                //search screen
                GoRoute(
                    path: AppRoutes.categorySearchScreen,
                    parentNavigatorKey: AppRouter.rootNavigatorKey,
                    name: AppRoutes.categorySearchScreen,
                    builder: (context, state) => SearchScreen(
                          isHome: false,
                        ),
                    routes: [
                      //store screen
                      GoRoute(
                        path: AppRoutes.categoryStoreListScreen,
                        parentNavigatorKey: AppRouter.rootNavigatorKey,
                        name: AppRoutes.categoryStoreListScreen,
                        builder: (context, state) => StoreScreenList(),
                      ),
                    ]),
               
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

        // otp  Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.otp,
          name: 'otp',
          builder: (context, state) => OtpScreen(
            mobileNumber: state.extra as String,
          ),
        ),

        // account setup  Route (Outside ShellRoute)
        GoRoute(
          path: AppRoutes.accountSetup,
          name: 'account-setup',
          builder: (context, state) => AccountSetupScreen(),
        ),

        GoRoute(
          path: AppRoutes.locationSelection,
          name: 'location-selection',
          builder: (context, state) => LocationSelectionScreen(),
        ),
      ];
  static Future<String?> _redirectLogic(
      BuildContext context, GoRouterState state) async {
    final logger = AppLogger();
    final authService = AuthPreferenceService();

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
      final bool hasSelectedLocation = await authService.hasSelectedLocation();

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
