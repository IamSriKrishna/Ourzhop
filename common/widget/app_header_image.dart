// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_style.dart';

/// App Header Image Component
///
/// A reusable header image widget that displays an image with
/// gradient background, following the design system.
/// Used in authentication screens and other content headers.
class AppHeaderImage extends StatelessWidget {
  /// Creates an App Header Image component
  const AppHeaderImage({
    super.key,
    this.imageAsset,
    this.height = 160.0,
    this.width = 160.0,
    this.gradient,
    this.borderRadius,
  });

  /// Asset path for the header image
  final String? imageAsset;

  /// Height of the header image container
  final double height;

  /// Width of the header image container
  final double width;

  /// Custom gradient for the background
  final LinearGradient? gradient;

  /// Border radius for the image container
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: imageAsset != null
          ? Image.asset(
              imageAsset!,
              height: height,
              width: width,
              fit:
                  BoxFit.contain, // Changed to contain to maintain aspect ratio
              errorBuilder: (context, error, stackTrace) {
                // Fallback to placeholder if image fails to load
                return _buildPlaceholder(context);
              },
            )
          : _buildPlaceholder(context),
    );
  }

  /// Builds the placeholder widget when no image is available
  Widget _buildPlaceholder(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ??
            BorderRadius.circular(AppDesignTokens.borderRadiusSmall),
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_outlined,
            size: height * 0.25,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          if (height > 100) ...[
            SizedBox(height: AppDesignTokens.spacingXs),
            Text(
              'Image',
              style: AppFonts.getBodyStyle(
                context,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
