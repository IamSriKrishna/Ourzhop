
// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_icons.dart';
import 'package:flutter/material.dart';

class CartCouponSection extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData icon;
  final EdgeInsets? margin;

  const CartCouponSection({
    super.key,
    this.onTap,
    this.title = 'Apply Coupon',
    this.icon = Icons.local_offer_outlined,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
         decoration: BoxDecoration(
       color: isDark ? null : Colors.white,
        gradient: isDark
            ? LinearGradient(
                colors: [
                  colorScheme.primary.withOpacity(0.1),
                  colorScheme.primary.withOpacity(0.05),
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
        child: Row(
          children: [
           Image.asset(AppIcons.coupon),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade600,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
