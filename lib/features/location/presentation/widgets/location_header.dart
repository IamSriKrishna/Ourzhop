
import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_style.dart';

class LocationHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const LocationHeader({
    super.key,
    this.title = "Select location",
    this.subtitle = "Use current location or search your own\nlocation",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.getAppBarTitle(context).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: AppTypography.getBodyText(context).copyWith(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}