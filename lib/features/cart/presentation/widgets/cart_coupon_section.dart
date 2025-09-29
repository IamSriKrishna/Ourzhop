
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
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
