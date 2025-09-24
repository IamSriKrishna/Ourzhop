
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DiscountBadge extends StatelessWidget {
  final String discount;

  const DiscountBadge({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: context.appColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        discount,
        style: TextStyle(
          color: context.appColors.onPrimary,
          fontSize: 8,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}