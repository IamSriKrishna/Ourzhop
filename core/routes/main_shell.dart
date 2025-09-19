// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/widget/app_named_navigation_bar_item.dart';
import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/bottom_navigation/bottom_navigation_cubit.dart';

/// Main shell widget that contains the bottom navigation and displays the child content
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: const BottomNavigationWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/// Bottom navigation widget that updates based on current route
class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AppNamedNavigationBarItem> tabs = _buildTabs(context);

    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        // Auto-update the selected index based on current route
        _updateSelectedIndexBasedOnRoute(context, tabs);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;
              final isSelected = state.index == index;

              return GestureDetector(
                onTap: () => _onNavItemTapped(context, state, tabs, index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color.fromRGBO(234, 217, 255, 1)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconTheme(
                      data: IconThemeData(
                        color: isSelected
                            ? const Color(0xFF7C3AED)
                            : Colors.grey[600],
                        size: 24,
                      ),
                      child: tab.icon,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  List<AppNamedNavigationBarItem> _buildTabs(BuildContext context) {
    return [
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.home,
        icon: Image.asset(AppIcons.home),
        label: context.tr.bottomNavHome,
      ),
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.categoryScreen,
        icon: Image.asset(AppIcons.more),
        label: context.tr.bottomNavCategories,
      ),
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.cartScreen,
        icon: Image.asset(AppIcons.shoppingBag),
        label: context.tr.bottomNavCart,
      ),
    ];
  }

  void _updateSelectedIndexBasedOnRoute(
    BuildContext context,
    List<AppNamedNavigationBarItem> tabs,
  ) {
    final location = GoRouterState.of(context).uri.toString();
    int newIndex = 0;

    for (int i = 0; i < tabs.length; i++) {
      if (location == tabs[i].initialLocation) {
        newIndex = i;
        break;
      }
    }

    final cubit = context.read<BottomNavigationCubit>();
    if (cubit.state.index != newIndex) {
      cubit.selectNavBarItem(newIndex);
    }
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
