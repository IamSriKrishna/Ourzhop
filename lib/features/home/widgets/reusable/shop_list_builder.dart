import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:customer_app/features/home/widgets/reusable/shop_state_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopListBuilder extends StatelessWidget {
  const ShopListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        switch (state) {
          case ShopInitial():
            return ShopStateWidgets.locationLoading(context);
          case ShopLoading():
            return const Padding(
              padding: EdgeInsets.all(40.0),
              child: CircularProgressIndicator(),
            );
          case ShopLoaded():
            if (state.shops.isEmpty) {
              return ShopStateWidgets.emptyState(context);
            }
            return ShopStateWidgets.loadedState(context, state);
          case ShopError():
            return ShopStateWidgets.errorState(context, state.message);
          case SearchLoading():
          case SearchResultsLoaded():
          case SearchError():
          case SearchCleared():
            throw UnimplementedError();
        }
      },
    );
  }
}
