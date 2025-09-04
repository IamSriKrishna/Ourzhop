// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/widget/app_named_navigation_bar_item.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/bottom_navigation/bottom_navigation_cubit.dart';

// Project imports

class HomeScreen extends StatelessWidget {
  final Widget screen;

  const HomeScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    final List<AppNamedNavigationBarItem> tabs = _buildTabs(context);
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, tabs),
    );
  }

  List<AppNamedNavigationBarItem> _buildTabs(BuildContext context) {
    return [
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.home,
        icon: const Icon(Icons.home),
        label: context.tr.bottomNavHubs,
      ),
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.profile,
        icon: const Icon(Icons.person),
        label: context.tr.bottomNavProfile,
      ),

      // Add more tabs if needed
    ];
  }

  Widget _buildBottomNavigation(
      BuildContext context, List<AppNamedNavigationBarItem> tabs) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) => _onNavItemTapped(context, state, tabs, index),
          showSelectedLabels: true,
          items: tabs,
        );
      },
    );
  }

  void _onNavItemTapped(
    BuildContext context,
    BottomNavigationState state,
    List<AppNamedNavigationBarItem> tabs,
    int index,
  ) {
    if (state.index != index) {
      context.read<BottomNavigationCubit>().selectNavBarItem(index);
      context.go(tabs[index].initialLocation);
    }
  }
}
