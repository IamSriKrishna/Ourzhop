import 'package:customer_app/features/home/presentation/cubit/location_cubit.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: state is ShopLoaded
                  ? state.isLoadingMore
                      ? const CircularProgressIndicator()
                      : (state.meta.hasMore ?? false)
                          ? BlocBuilder<LocationCubit, LocationState>(
                              builder: (context, locationState) {
                                return ElevatedButton(
                                  onPressed: locationState.lat != null &&
                                          locationState.lng != null
                                      ? () {
                                          context.read<ShopBloc>().add(
                                                LoadMoreShopsEvent(
                                                  limit: 10,
                                                  lat: locationState.lat!,
                                                  lng: locationState.lng!,
                                                ),
                                              );
                                        }
                                      : null,
                                  child: const Text("Load more shops"),
                                );
                              },
                            )
                          : Text(
                              "No more shops to load",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
