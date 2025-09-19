// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/presentation/bloc/home_event.dart';
import 'package:customer_app/features/home/presentation/widgets/home_header_section.dart';
import 'package:customer_app/features/home/presentation/widgets/home_category_section.dart';
import 'package:customer_app/features/home/presentation/widgets/home_banner_section.dart';
import 'package:customer_app/features/home/presentation/widgets/home_delivery_toggle_section.dart';
import 'package:customer_app/features/home/presentation/widgets/home_recommended_section.dart';
import 'package:customer_app/features/home/presentation/widgets/home_shop_list_section.dart';

/// Home content wrapper that displays home content without scaffold/bottom navigation
/// This is used within the MainShell to show home content while keeping bottom navigation
class HomeContentWrapper extends StatefulWidget {
  const HomeContentWrapper({super.key});

  @override
  State<HomeContentWrapper> createState() => _HomeContentWrapperState();
}

class _HomeContentWrapperState extends State<HomeContentWrapper> {
  @override
  void initState() {
    super.initState();
    // Initialize all sections
    _initializeSections();
  }

  void _initializeSections() {
    final homeBloc = context.read<HomeBloc>();

    // Load categories for category section
    homeBloc.add(const HomeCategoryLoadRequested());

    // Load other sections (skeletal for now)
    homeBloc.add(const HomeShopLoadRequested());
    homeBloc.add(const HomeRecommendedLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          slivers: [
            // Header Section - Search + Location + Profile
            const SliverToBoxAdapter(
              child: HomeHeaderSection(),
            ),

            // Category Section - Category tabs (All/Grocery/Electronics/etc.)
            const SliverToBoxAdapter(
              child: HomeCategorySection(),
            ),

            // Banner Section - Promotional banners
            const SliverToBoxAdapter(
              child: HomeBannerSection(),
            ),

            // Delivery Toggle Section - Delivery/Pickup buttons
            const SliverToBoxAdapter(
              child: HomeDeliveryToggleSection(),
            ),

            // Recommended Section - Recommended stores grid
            const SliverToBoxAdapter(
              child: HomeRecommendedSection(),
            ),

            // Shop List Section - Shop list
            const SliverToBoxAdapter(
              child: HomeShopListSection(),
            ),

            // Add some bottom padding for the last section
            const SliverToBoxAdapter(
              child: SizedBox(height: 100.0), // Space for bottom navigation
            ),
          ],
        ),
      ),
    );
  }

  /// Handle pull-to-refresh for all sections
  Future<void> _handleRefresh() async {
    final homeBloc = context.read<HomeBloc>();

    // Refresh all sections
    homeBloc.add(const HomeCategoryRefresh());
    homeBloc.add(const HomeShopRefresh());
    homeBloc.add(const HomeRecommendedRefresh());

    // Wait a bit for the refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
