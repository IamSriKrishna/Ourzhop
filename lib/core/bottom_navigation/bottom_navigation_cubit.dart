// Package imports:

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/constants/app_route_constants.dart';

// Project imports:

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(BottomNavigationState(bottomNavItem: AppRoutes.home, index: 0));

  void selectNavBarItem(int index) {
    String navItem;
    switch (index) {
      case 0:
        navItem = AppRoutes.home;
        break;
      case 1:
        navItem = AppRoutes.categoryScreen;
        break;
      case 2:
        navItem = AppRoutes.cartScreen;
        break;

      default:
        return; // Optionally add error handling or logging here
    }
    emit(BottomNavigationState(bottomNavItem: navItem, index: index));
  }
}
