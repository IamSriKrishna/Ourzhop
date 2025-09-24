
import 'package:customer_app/features/home/presentation/cubit/location_cubit.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:customer_app/features/home/widgets/home_content_subwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopStateWidgets {
  static Widget locationLoading(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.location_searching,
            size: 48,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Getting your location...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we find nearby shops',
            style: TextStyle(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget emptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, locationState) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.store_outlined,
                size: 64,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                'No shops found nearby',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try adjusting your location or check back later',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: locationState.lat != null && locationState.lng != null
                    ? () {
                        context.read<ShopBloc>().add(
                              RefreshShopsEvent(
                                limit: 10,
                                lat: locationState.lat!,
                                lng: locationState.lng!,
                              ),
                            );
                      }
                    : null,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget loadedState(BuildContext context, ShopLoaded state) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        ...state.shops.map((shop) =>
            HomeContentSubwidget.buildShopCard(context, shop: shop)),
        if (state.error != null)
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Error loading more shops: ${state.error}',
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
          ),
      ],
    );
  }

  static Widget errorState(BuildContext context, String message) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, locationState) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: colorScheme.onErrorContainer,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                'Failed to load shops',
                style: TextStyle(
                  color: colorScheme.onErrorContainer,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: TextStyle(color: colorScheme.onErrorContainer),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: locationState.lat != null && locationState.lng != null
                    ? () {
                        context.read<ShopBloc>().add(
                              RefreshShopsEvent(
                                limit: 10,
                                lat: locationState.lat!,
                                lng: locationState.lng!,
                              ),
                            );
                      }
                    : null,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      },
    );
  }
}