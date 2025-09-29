// Flutter imports:
import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/widget/app_named_navigation_bar_item.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/bottom_navigation/bottom_navigation_cubit.dart';
class HomeScreen extends StatelessWidget {
  final Widget screen;

  const HomeScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    final List<AppNamedNavigationBarItem> tabs = _buildTabs(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screen,
      floatingActionButton: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) => 
          previous.totalItems != current.totalItems,
        builder: (context, cartState) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFloatingBottomNavigation(context, tabs),
              // Only show cart if there are items
              if (cartState.totalItems > 0) 
                _cart(context, cartState.totalItems),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<AppNamedNavigationBarItem> _buildTabs(BuildContext context) {
    return [
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.home,
        icon: Image.asset(AppIcons.home),
        label: context.tr.bottomNavHubs,
      ),
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.categoryScreen,
        icon: Image.asset(AppIcons.more),
        label: context.tr.bottomNavProfile,
      ),
      AppNamedNavigationBarItem(
        initialLocation: AppRoutes.cartScreen,
        icon: Image.asset(AppIcons.shoppingBag),
        label: context.tr.bottomNavProfile,
      ),
    ];
  }

  Widget _buildFloatingBottomNavigation(
      BuildContext context, List<AppNamedNavigationBarItem> tabs) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
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

  Widget _cart(BuildContext context, int itemCount) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          context.go(AppRoutes.cartScreen);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconTheme(
              data: IconThemeData(
                color: Colors.grey[600],
                size: 24,
              ),
              child: Badge.count(
                backgroundColor: context.appColors.primary,
                alignment: const Alignment(5, -1.2),
                count: itemCount,
                child: Image.asset(AppIcons.cart),
              ),
            ),
          ),
        ),
      ),
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