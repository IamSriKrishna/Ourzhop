import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:customer_app/features/store/presentation/bloc/product_bloc.dart';
import 'package:customer_app/features/store/presentation/bloc/product_event.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/features/store/presentation/widgets/store_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreen extends StatelessWidget {
  final String shopId;

  const StoreScreen({
    super.key,
    required this.shopId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => serviceLocator<ProductBloc>()
        ..add(LoadProductsEvent(shopId: shopId))
        ..add(LoadFiltersEvent(shopId: shopId)),
      child: Scaffold(
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
            const Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: CartBottomWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
