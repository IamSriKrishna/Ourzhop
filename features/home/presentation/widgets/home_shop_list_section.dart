// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/home/presentation/bloc/home_event.dart';
import 'package:customer_app/features/home/presentation/bloc/home_state.dart';
import 'package:customer_app/features/shop/domain/entities/shop_entity.dart';

class HomeShopListSection extends StatelessWidget {
  const HomeShopListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Shops',
                style: AppFonts.poppins(
                  size: 18.0,
                  weight: FontWeight.w600,
                  color: AppColors.darkGray,
                ),
              ),
              GestureDetector(
                onTap: () => _handleFilterTap(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryPurple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: AppColors.primaryPurple,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Filter',
                        style: AppFonts.poppins(
                          size: 12.0,
                          weight: FontWeight.w500,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Shop List Content
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.shopState != current.shopState,
            builder: (context, state) {
              final shopState = state.shopState;

              if (shopState is HomeShopInitial) {
                return Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryPurple));
              }

              if (shopState is HomeShopLoading) {
                return Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryPurple));
              }

              if (shopState is HomeShopSuccess) {
                return _buildShopList(context, shopState.shops);
              }

              if (shopState is HomeShopFailure) {
                return _buildErrorWidget(context, shopState.error);
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShopList(BuildContext context, List<ShopEntity> shops) {
    if (shops.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store_outlined,
              size: 64.0,
              color: AppColors.mediumGray,
            ),
            const SizedBox(height: 16.0),
            Text(
              'No shops found',
              style: AppFonts.poppins(
                size: 16.0,
                weight: FontWeight.w500,
                color: AppColors.mediumGray,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Try adjusting your location or filters',
              style: AppFonts.poppins(
                size: 14.0,
                color: AppColors.mediumGray,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shops.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemBuilder: (context, index) {
        final shop = shops[index];
        return _buildShopItem(context, shop);
      },
    );
  }

  Widget _buildShopItem(BuildContext context, ShopEntity shop) {
    return GestureDetector(
      onTap: () => _handleShopTap(context, shop),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.lightGray,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkGray.withValues(alpha: 0.05),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Shop Icon/Image
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: shop.primaryImageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          shop.primaryImageUrl,
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.store,
                              color: AppColors.primaryPurple,
                              size: 28.0,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.store,
                        color: AppColors.primaryPurple,
                        size: 28.0,
                      ),
              ),

              const SizedBox(width: 12.0),

              // Shop Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shop Name
                    Text(
                      shop.name,
                      style: AppFonts.poppins(
                        size: 16.0,
                        weight: FontWeight.w600,
                        color: AppColors.darkGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4.0),

                    // Shop Tags/Categories
                    if (shop.shopTags.isNotEmpty)
                      Text(
                        shop.shopTags.join(' • '),
                        style: AppFonts.poppins(
                          size: 12.0,
                          color: AppColors.mediumGray,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 8.0),

                    // Rating, Distance, and Delivery Info
                    Row(
                      children: [
                        // Rating
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 14.0,
                        ),
                        const SizedBox(width: 2.0),
                        Text(
                          shop.avgRating.toStringAsFixed(1),
                          style: AppFonts.poppins(
                            size: 12.0,
                            weight: FontWeight.w500,
                            color: AppColors.darkGray,
                          ),
                        ),

                        const SizedBox(width: 8.0),

                        // Distance
                        Text(
                          '${shop.distanceKm.toStringAsFixed(1)} km',
                          style: AppFonts.poppins(
                            size: 12.0,
                            color: AppColors.mediumGray,
                          ),
                        ),

                        const SizedBox(width: 8.0),

                        // Delivery Time
                        if (shop.isDeliveryEnabled)
                          Text(
                            shop.deliveryReadyTime,
                            style: AppFonts.poppins(
                              size: 12.0,
                              color: AppColors.mediumGray,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4.0),

                    // Location Info
                    Text(
                      '${shop.area}, ${shop.city} - ${shop.pincode}',
                      style: AppFonts.poppins(
                        size: 11.0,
                        color: AppColors.mediumGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Status Indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Online Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: shop.isOnline
                          ? Colors.green.withValues(alpha: 0.1)
                          : Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      shop.isOnline ? 'OPEN' : 'CLOSED',
                      style: AppFonts.poppins(
                        size: 9.0,
                        weight: FontWeight.w600,
                        color: shop.isOnline ? Colors.green : Colors.red,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8.0),

                  // Delivery/Pickup Options
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (shop.isDeliveryEnabled)
                        Icon(
                          Icons.delivery_dining,
                          color: AppColors.primaryPurple,
                          size: 14.0,
                        ),
                      if (shop.isDeliveryEnabled && shop.isPickupEnabled)
                        const SizedBox(width: 4.0),
                      if (shop.isPickupEnabled)
                        Icon(
                          Icons.store_mall_directory,
                          color: AppColors.primaryPurple,
                          size: 14.0,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.mediumGray,
            size: 32.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Failed to load shops',
            style: AppFonts.poppins(
              size: 14.0,
              color: AppColors.mediumGray,
            ),
          ),
          const SizedBox(height: 4.0),
          TextButton(
            onPressed: () => _handleRetry(context),
            child: Text(
              'Retry',
              style: AppFonts.poppins(
                size: 14.0,
                weight: FontWeight.w600,
                color: AppColors.primaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleFilterTap(BuildContext context) {
    // TODO: Show filter bottom sheet or navigate to filter screen
    debugPrint('Filter tapped');
  }

  void _handleShopTap(BuildContext context, ShopEntity shop) {
    // TODO: Navigate to shop detail screen
    debugPrint('Shop tapped: ${shop.name}');
  }

  void _handleRetry(BuildContext context) {
    context.read<HomeBloc>().add(const HomeShopLoadRequested());
  }
}
