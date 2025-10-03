// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final String label;
  final double height;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.isEnabled,
    required this.label,
    this.height = 58.0,
    this.borderRadius = 30.0,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: isEnabled
            ? LinearGradient(
                colors: [
                  appColors.primary,
                  appColors.primary.withOpacity(0.8),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isEnabled ? null : Colors.grey[300],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: AppTypography.getButtonText(context).copyWith(
            color: isEnabled ? Colors.white : Colors.grey[600],
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
