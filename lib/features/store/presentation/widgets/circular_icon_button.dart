import 'package:customer_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double? size;
  final Color? backgroundColor;
  final Color? iconColor;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 40,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.appColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: context.appColors.outline.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor ?? context.appColors.primary,
          size: 20,
        ),
      ),
    );
  }
}
