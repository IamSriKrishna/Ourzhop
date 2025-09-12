import 'package:customer_app/features/home/widgets/store_widgets.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StoreWidgets.appBar(context),
          StoreWidgets.searchBar(context),
          StoreWidgets.categoryTabs(context),
          StoreWidgets.offerProducts(context),
          StoreWidgets.dairyBreadEgg(context),
          StoreWidgets.vegetablesFruits(context),
        ],
      ),
    );
  }
}
