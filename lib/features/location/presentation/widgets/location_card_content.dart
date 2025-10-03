import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_style.dart';

class LocationCardContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? titleFontSize;
  final double? subtitleFontSize;
  final FontWeight? titleFontWeight;

  const LocationCardContent({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleFontSize,
    this.subtitleFontSize,
    this.titleFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.getBodyText(context).copyWith(
            fontWeight: titleFontWeight ?? FontWeight.w600,
            fontSize: titleFontSize ?? 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: AppTypography.getBodyText(context).copyWith(
            fontSize: subtitleFontSize ?? 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
