import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:customer_app/features/home/widgets/async_user_wrapper.dart';
import 'package:customer_app/features/order_tracking/presentation/widgets/bill_details_section.dart';
import 'package:customer_app/features/order_tracking/presentation/widgets/item_details_section.dart';
import 'package:customer_app/features/order_tracking/presentation/widgets/store_info_card.dart';
import 'package:customer_app/features/order_tracking/presentation/widgets/track_order_section.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  
  const OrderTrackingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    final authPrefs = serviceLocator<AuthPreferenceService>();
    return AsyncUserWrapper(
      authPrefs: authPrefs,
      builder: (context, user) {
        final colorScheme = Theme.of(context).colorScheme;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              CartAppBar(
                title: "Order",
                location: "#0907045s",
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: const SizedBox(height: 16),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    StoreInfoCard(
                      colorScheme: colorScheme,
                      myAddress: user.location!,
                    ),
                    const SizedBox(height: 20),
                    TrackOrderSection(colorScheme: colorScheme),
                    const SizedBox(height: 20),
                    ItemDetailsSection(colorScheme: colorScheme),
                    const SizedBox(height: 20),
                    BillDetailsSection(colorScheme: colorScheme),
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}