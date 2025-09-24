import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/widgets/cart_bottom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/store/presentation/widgets/store_widgets.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Builder(
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
      ),
    );
  }
}