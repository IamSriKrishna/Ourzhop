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

class HomeRecommendedSection extends StatelessWidget {
  const HomeRecommendedSection({super.key});

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
                'Recommended for You',
                style: AppFonts.poppins(
                  size: 18.0,
                  weight: FontWeight.w600,
                  color: AppColors.darkGray,
                ),
              ),
              GestureDetector(
                onTap: () => _handleSeeAllTap(context),
                child: Text(
                  'See All',
                  style: AppFonts.poppins(
                    size: 14.0,
                    weight: FontWeight.w600,
                    color: AppColors.primaryPurple,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16.0),

          // Recommended Content
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.recommendedState != current.recommendedState,
            builder: (context, state) {
              final recommendedState = state.recommendedState;

              if (recommendedState is HomeRecommendedInitial) {
                return Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryPurple));
              }

              if (recommendedState is HomeRecommendedLoading) {
                return Center(
                    child: CircularProgressIndicator(
                        color: AppColors.primaryPurple));
              }

              if (recommendedState is HomeRecommendedSuccess) {
                return _buildRecommendedGrid(context);
              }

              if (recommendedState is HomeRecommendedFailure) {
                return _buildErrorWidget(context, recommendedState.error);
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedGrid(BuildContext context) {
    // Mock data for recommended stores
    final List<Map<String, dynamic>> recommendedStores = [
      {
        'name': 'Fresh Mart',
        'category': 'Grocery',
        'rating': 4.5,
        'deliveryTime': '30 mins',
        'image': Icons.store,
      },
      {
        'name': 'TechHub Electronics',
        'category': 'Electronics',
        'rating': 4.3,
        'deliveryTime': '45 mins',
        'image': Icons.devices,
      },
      {
        'name': 'Fashion Trends',
        'category': 'Fashion',
        'rating': 4.7,
        'deliveryTime': '25 mins',
        'image': Icons.shopping_bag,
      },
      {
        'name': 'Book Paradise',
        'category': 'Books',
        'rating': 4.4,
        'deliveryTime': '40 mins',
        'image': Icons.menu_book,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: recommendedStores.length,
      itemBuilder: (context, index) {
        final store = recommendedStores[index];
        return _buildRecommendedItem(context, store);
      },
    );
  }

  Widget _buildRecommendedItem(
      BuildContext context, Map<String, dynamic> store) {
    return GestureDetector(
      onTap: () => _handleStoreTap(context, store),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store Image/Icon
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Icon(
                  store['image'] as IconData,
                  color: AppColors.primaryPurple,
                  size: 40.0,
                ),
              ),
            ),

            // Store Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store Name
                    Text(
                      store['name'] as String,
                      style: AppFonts.poppins(
                        size: 14.0,
                        weight: FontWeight.w600,
                        color: AppColors.darkGray,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 2.0),

                    // Category
                    Text(
                      store['category'] as String,
                      style: AppFonts.poppins(
                        size: 12.0,
                        color: AppColors.mediumGray,
                      ),
                    ),

                    const SizedBox(height: 4.0),

                    // Rating and Delivery Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 12.0,
                            ),
                            const SizedBox(width: 2.0),
                            Text(
                              store['rating'].toString(),
                              style: AppFonts.poppins(
                                size: 11.0,
                                weight: FontWeight.w500,
                                color: AppColors.darkGray,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          store['deliveryTime'] as String,
                          style: AppFonts.poppins(
                            size: 10.0,
                            color: AppColors.mediumGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            'Failed to load recommendations',
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

  void _handleSeeAllTap(BuildContext context) {
    // TODO: Navigate to full recommended stores screen
    debugPrint('See All recommended stores tapped');
  }

  void _handleStoreTap(BuildContext context, Map<String, dynamic> store) {
    // TODO: Navigate to store detail screen
    debugPrint('Store tapped: ${store['name']}');
  }

  void _handleRetry(BuildContext context) {
    context.read<HomeBloc>().add(const HomeRecommendedLoadRequested());
  }
}
