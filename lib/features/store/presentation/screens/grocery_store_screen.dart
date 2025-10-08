
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/home/presentation/models/product_model.dart';
import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:customer_app/features/store/presentation/widgets/category_filter_bar.dart';
import 'package:customer_app/features/store/presentation/widgets/category_side_bar.dart';
import 'package:customer_app/features/store/presentation/widgets/grocery_app_bar.dart';
import 'package:customer_app/features/store/presentation/widgets/product_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroceryHomePage extends StatefulWidget {
  final String shopId;

  const GroceryHomePage({
    super.key,
    required this.shopId,
  });

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              GroceryAppBar(onBack: () => context.pop()),
              CategoryFilterBar(),
              SliverFillRemaining(
                child: Container(
                  color: context.appColors.surface,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategorySidebar(),
                      ProductGrid(products: products),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: CartBottomWidget(),
          ),
        ],
      ),
    );
  }
}