import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/features/home/widgets/home_content_subwidget.dart';
import 'package:flutter/material.dart';

class HomeContentWidgets {
  HomeContentWidgets._();

  static Widget searchAndLocation(String location, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.primary,
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for "store name"',
                        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Current Location',
                  style: TextStyle(
                    color: colorScheme.onPrimary.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location.toCapital,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Transform.rotate(
                      angle: 1.5708,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: colorScheme.onPrimary,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget appBar(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 0.5, 1.0],
            colors: [
              colorScheme.primary,
              colorScheme.primary,
              colorScheme.surface,
              colorScheme.surface,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeContentSubwidget.buildStickyCategory(
                      'All', Icons.apps, false, context),
                  HomeContentSubwidget.buildStickyCategory(
                      'Grocery', Icons.shopping_cart, true, context),
                  HomeContentSubwidget.buildStickyCategory(
                      'Electronics', Icons.headphones, false, context),
                  HomeContentSubwidget.buildStickyCategory(
                      'Bakery', Icons.cake, false, context),
                  HomeContentSubwidget.buildStickyCategory(
                      'Medicine', Icons.medical_services, false, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget content(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        child: Column(
          children: [
            const SizedBox(height: 30),
            HomeContentSubwidget.homeCarousel(context),
            HomeContentSubwidget.tabContent(context),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recommended',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            HomeContentSubwidget.recommendedWidgets(context),
            const SizedBox(height: 20),
            ...List.generate(
                5, (index) => HomeContentSubwidget.buildStoreCard(context)),
          ],
        ),
      ),
    );
  }
}