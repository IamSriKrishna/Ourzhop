
import 'package:customer_app/features/home/presentation/cubit/location_cubit.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyShopsSection extends StatelessWidget {
  const NearbyShopsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'Nearby Shops',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          BlocBuilder<LocationCubit, LocationState>(
            builder: (context, locationState) {
              return BlocBuilder<ShopBloc, ShopState>(
                builder: (context, shopState) {
                  if (shopState is ShopLoaded) {
                    return TextButton.icon(
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
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Refresh'),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
