// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

class HomeBannerSection extends StatelessWidget {
  const HomeBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Special Offers',
            style: AppFonts.poppins(
              size: 18.0,
              weight: FontWeight.w600,
              color: AppColors.darkGray,
            ),
          ),

          const SizedBox(height: 12.0),

          // Banner Container
          SizedBox(
            height: 120.0,
            child: PageView.builder(
              itemCount: 3, // Mock banner count
              itemBuilder: (context, index) => _buildBannerItem(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerItem(BuildContext context, int index) {
    final List<Color> bannerColors = [
      AppColors.primaryPurple,
      AppColors.primaryPurpleDark,
      AppColors.primaryPurpleLight,
    ];

    final List<String> bannerTitles = [
      'Fresh Groceries Delivered',
      '50% Off Electronics',
      'Free Delivery This Weekend',
    ];

    return Container(
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            bannerColors[index % bannerColors.length],
            bannerColors[index % bannerColors.length].withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bannerTitles[index % bannerTitles.length],
              style: AppFonts.poppins(
                size: 16.0,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Shop now and save big!',
              style: AppFonts.poppins(
                size: 12.0,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'Shop Now',
                style: AppFonts.poppins(
                  size: 12.0,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
