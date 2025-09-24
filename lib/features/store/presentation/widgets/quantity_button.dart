
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: context.appColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: context.appColors.onPrimary,
          size: 16,
        ),
      ),
    );
  }
}