// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_style.dart';

/// Reusable title section component for authentication screens
///
/// This widget provides a consistent title and subtitle layout for auth screens
/// with customizable text and spacing
class AppAuthTitleSection extends StatelessWidget {
  const AppAuthTitleSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.spacing = 11.0,
    this.alignment = CrossAxisAlignment.start,
  });

  final String title;
  final String subtitle;
  final double spacing;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: AppTypography.getLoginTitle(context),
        ),
        SizedBox(height: spacing),
        Text(
          subtitle,
          style: AppTypography.getLoginSubtitle(context),
        ),
      ],
    );
  }
}
