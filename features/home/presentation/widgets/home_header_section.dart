// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/service_locator.dart';

class HomeHeaderSection extends StatefulWidget {
  const HomeHeaderSection({super.key});

  @override
  State<HomeHeaderSection> createState() => _HomeHeaderSectionState();
}

class _HomeHeaderSectionState extends State<HomeHeaderSection> {
  final _userPrefs = serviceLocator<UserPreferenceService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Search Icon
          GestureDetector(
            onTap: () => _handleSearchTap(context),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.lightGray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.search,
                color: AppColors.darkGray,
                size: 24.0,
              ),
            ),
          ),

          const SizedBox(width: 16.0),

          // Location Section
          Expanded(
            child: GestureDetector(
              onTap: () => _handleLocationTap(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primaryPurple,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Deliver to',
                        style: AppFonts.poppins(
                          size: 12.0,
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  FutureBuilder<String?>(
                    future: _userPrefs.getLocationMainText(),
                    builder: (context, snapshot) {
                      String locationText =
                          'Chennai, Tamil Nadu'; // Default fallback

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show default text while loading
                        locationText = 'Loading location...';
                      } else if (snapshot.hasData && snapshot.data != null) {
                        locationText = snapshot.data!;
                      } else if (snapshot.hasError) {
                        // Show default on error
                        locationText = 'Chennai, Tamil Nadu';
                      }

                      return Text(
                        locationText,
                        style: AppFonts.poppins(
                          size: 14.0,
                          weight: FontWeight.w600,
                          color: AppColors.darkGray,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16.0),

          // Profile Icon
          GestureDetector(
            onTap: () => _handleProfileTap(context),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.person_outline,
                color: AppColors.primaryPurple,
                size: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSearchTap(BuildContext context) {
    // TODO: Navigate to search screen
    debugPrint('Search tapped');
  }

  void _handleLocationTap(BuildContext context) {
    // TODO: Navigate to location selection screen
    debugPrint('Location tapped');
  }

  void _handleProfileTap(BuildContext context) {
    GoRouter.of(context).push('/profile-screen');
  }
}
