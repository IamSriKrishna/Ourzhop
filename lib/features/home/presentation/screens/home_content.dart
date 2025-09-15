import 'package:customer_app/constants/app_images.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/home/domain/usecase/category_usecase.dart';
import 'package:customer_app/features/home/domain/usecase/shop_usecase.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
import 'package:customer_app/features/home/widgets/home_content_subwidget.dart';
import 'package:customer_app/features/home/widgets/home_content_widgets.dart';
import 'package:customer_app/features/home/widgets/location_helper.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _authPrefs = serviceLocator<AuthPreferenceService>();
  double? _currentLat;
  double? _currentLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final coordinates = await LocationHelper.getCoordinates();
      if (coordinates != null && mounted) {
        setState(() {
          _currentLat = coordinates.lat;
          _currentLng = coordinates.lng;
        });
      }
    } catch (e) {
      setState(() {
        _currentLat = 12.8738; 
        _currentLng = 80.0784;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FutureBuilder<UserModel?>(
      future: _authPrefs.getUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            ),
          );
        }
        if (snap.hasError) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: Text(
                'Error: ${snap.error}',
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          );
        }
        final user = snap.data!;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CategoryBloc(
                getCategories: serviceLocator<GetCategoriesUseCase>(),
              )..add(GetCategoriesEvent(limit: 10, cursor: null)),
            ),
            BlocProvider(
              create: (_) {
                final bloc = ShopBloc(
                  getShopsByLocation: serviceLocator<GetShopsByLocationUseCase>(),
                );
                
                if (_currentLat != null && _currentLng != null) {
                  bloc.add(GetShopsByLocationEvent(
                    limit: 10,
                    lat: _currentLat!,
                    lng: _currentLng!,
                    cursor: null,
                  ));
                }
                
                return bloc;
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
            body: CustomScrollView(
              slivers: [
                HomeContentWidgets.searchAndLocation(user.location!, context),
                HomeContentWidgets.appBar(context),
                _buildContent(context),
                _buildLoadMoreButton(context),
                SliverToBoxAdapter(
                  child: Image.asset(AppImages.homeWallpaper),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        child: Column(
          children: [
            const SizedBox(height: 30),
            HomeContentSubwidget.homeCarousel(context),
            HomeContentSubwidget.tabContent(context),
            const SizedBox(height: 30),
            
            // Recommended section (static for now)
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Recommended',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            HomeContentSubwidget.recommendedWidgets(context),
            const SizedBox(height: 20),
            
            // Nearby Shops section (dynamic)
            Container(
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
                  BlocBuilder<ShopBloc, ShopState>(
                    builder: (context, state) {
                      if (state is ShopLoaded) {
                        return TextButton.icon(
                          onPressed: () {
                            if (_currentLat != null && _currentLng != null) {
                              context.read<ShopBloc>().add(
                                RefreshShopsEvent(
                                  limit: 10,
                                  lat: _currentLat!,
                                  lng: _currentLng!,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('Refresh'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // Shop list
            BlocBuilder<ShopBloc, ShopState>(
              builder: (context, state) {
                switch (state) {
                  case ShopInitial():
                    return _buildLocationLoadingState(context);
                  case ShopLoading():
                    return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(),
                    );
                  case ShopLoaded():
                    if (state.shops.isEmpty) {
                      return _buildEmptyState(context);
                    }
                    return Column(
                      children: [
                        ...state.shops.map((shop) => 
                          HomeContentSubwidget.buildShopCard(context, shop: shop)
                        ),
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
                  case ShopError():
                    return _buildErrorState(context, state.message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadMoreButton(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: state is ShopLoaded
                  ? state.isLoadingMore
                      ? const CircularProgressIndicator()
                      : state.meta.hasMore
                          ? ElevatedButton(
                              onPressed: () {
                                if (_currentLat != null && _currentLng != null) {
                                  context.read<ShopBloc>().add(
                                    LoadMoreShopsEvent(
                                      limit: 10,
                                      lat: _currentLat!,
                                      lng: _currentLng!,
                                    ),
                                  );
                                }
                              },
                              child: const Text("Load more shops"),
                            )
                          : Text(
                              "No more shops to load",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationLoadingState(BuildContext context) {
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

  Widget _buildEmptyState(BuildContext context) {
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
            onPressed: () {
              if (_currentLat != null && _currentLng != null) {
                context.read<ShopBloc>().add(
                  RefreshShopsEvent(
                    limit: 10,
                    lat: _currentLat!,
                    lng: _currentLng!,
                  ),
                );
              }
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final colorScheme = Theme.of(context).colorScheme;
    
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
            onPressed: () {
              if (_currentLat != null && _currentLng != null) {
                context.read<ShopBloc>().add(
                  RefreshShopsEvent(
                    limit: 10,
                    lat: _currentLat!,
                    lng: _currentLng!,
                  ),
                );
              }
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}