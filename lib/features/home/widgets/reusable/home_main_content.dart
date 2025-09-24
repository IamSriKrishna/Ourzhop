import 'package:customer_app/features/home/widgets/home_content_subwidget.dart';
import 'package:customer_app/features/home/widgets/reusable/nearby_shops_section.dart';
import 'package:customer_app/features/home/widgets/reusable/shop_list_builder.dart';
import 'package:flutter/material.dart';

class HomeMainContent extends StatelessWidget {
  const HomeMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        child: Column(
          children: [
            const SizedBox(height: 30),
            HomeContentSubwidget.homeCarousel(context),
            HomeContentSubwidget.tabContent(context),
            const SizedBox(height: 30),
            NearbyShopsSection(),
            const SizedBox(height: 10),
            ShopListBuilder(),
          ],
        ),
      ),
    );
  }
}
