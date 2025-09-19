// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

class HomeDeliveryToggleSection extends StatefulWidget {
  const HomeDeliveryToggleSection({super.key});

  @override
  State<HomeDeliveryToggleSection> createState() =>
      _HomeDeliveryToggleSectionState();
}

class _HomeDeliveryToggleSectionState extends State<HomeDeliveryToggleSection> {
  int _selectedIndex = 0; // 0 for Delivery, 1 for Pickup

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Order Type',
            style: AppFonts.poppins(
              size: 18.0,
              weight: FontWeight.w600,
              color: AppColors.darkGray,
            ),
          ),

          const SizedBox(height: 12.0),

          // Toggle Buttons
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightGray.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildToggleButton(
                    context,
                    'Delivery',
                    Icons.delivery_dining,
                    0,
                  ),
                ),
                Expanded(
                  child: _buildToggleButton(
                    context,
                    'Pickup',
                    Icons.store_outlined,
                    1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12.0),

          // Delivery Info (shown when delivery is selected)
          if (_selectedIndex == 0) _buildDeliveryInfo(context),

          // Pickup Info (shown when pickup is selected)
          if (_selectedIndex == 1) _buildPickupInfo(context),
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    BuildContext context,
    String title,
    IconData icon,
    int index,
  ) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _handleToggle(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.mediumGray,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: AppFonts.poppins(
                size: 14.0,
                weight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.mediumGray,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.primaryPurple.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            color: AppColors.primaryPurple,
            size: 16.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            'Delivery in 30-45 mins • Free above ₹199',
            style: AppFonts.poppins(
              size: 12.0,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickupInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.primaryPurple.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule,
            color: AppColors.primaryPurple,
            size: 16.0,
          ),
          const SizedBox(width: 8.0),
          Text(
            'Ready for pickup in 15-20 mins',
            style: AppFonts.poppins(
              size: 12.0,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }

  void _handleToggle(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // TODO: Update global delivery/pickup preference
    debugPrint(
        'Delivery type changed to: ${index == 0 ? 'Delivery' : 'Pickup'}');
  }
}
