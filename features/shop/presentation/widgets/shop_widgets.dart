// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';

/// Shop card widget for displaying individual shop information
class ShopCard extends StatelessWidget {
  const ShopCard({
    super.key,
    required this.shop,
    this.onTap,
  });

  final ShopEntity shop;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement shop card UI
    return Card(
      child: ListTile(
        title: Text(shop.name),
        subtitle: Text('${shop.area}, ${shop.city}'),
        trailing: Text('${shop.distanceKm} km'),
        onTap: onTap,
      ),
    );
  }
}

/// Shop list widget for displaying a list of shops
class ShopList extends StatelessWidget {
  const ShopList({
    super.key,
    required this.shops,
    this.onShopTap,
  });

  final List<ShopEntity> shops;
  final void Function(ShopEntity shop)? onShopTap;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement shop list UI with proper layouts
    return ListView.builder(
      itemCount: shops.length,
      itemBuilder: (context, index) {
        final shop = shops[index];
        return ShopCard(
          shop: shop,
          onTap: () => onShopTap?.call(shop),
        );
      },
    );
  }
}

/// Shop loading widget
class ShopLoadingWidget extends StatelessWidget {
  const ShopLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement proper loading widget with shimmer effects
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// Shop error widget
class ShopErrorWidget extends StatelessWidget {
  const ShopErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
  });

  final String error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement proper error widget with retry functionality
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $error'),
          if (onRetry != null)
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}
