
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class StoreInfoHeader extends StatelessWidget {
  final String storeName;
  final String location;
  final String deliveryInfo;
  final String timeInfo;

  const StoreInfoHeader({
    super.key,
    required this.storeName,
    required this.location,
    required this.deliveryInfo,
    required this.timeInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$storeName, $location',
              style: TextStyle(
                color: context.appColors.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Icon(
              Icons.delivery_dining,
              color: context.appColors.onPrimary,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              deliveryInfo,
              style: TextStyle(
                color: context.appColors.onPrimary,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.access_time,
              color: context.appColors.onPrimary,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              timeInfo,
              style: TextStyle(
                color: context.appColors.onPrimary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}