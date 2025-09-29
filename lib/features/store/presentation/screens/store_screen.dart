
import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/features/store/presentation/widgets/store_widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  StoreWidgets.appBar(context),
                  StoreWidgets.searchBar(context),
                  StoreWidgets.categoryTabs(context),
                  StoreWidgets.offerProducts(context),
                  StoreWidgets.dairyBreadEgg(context),
                  StoreWidgets.vegetablesFruits(context),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: const CartBottomWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}