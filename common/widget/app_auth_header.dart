// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/common/widget/app_header_image.dart';

/// Reusable header component for authentication screens
///
/// This widget provides a consistent header layout for all auth screens
/// with customizable image dimensions and spacing
class AppAuthHeader extends StatelessWidget {
  const AppAuthHeader({
    super.key,
    required this.imageAsset,
    this.imageHeight = 160.0,
    this.imageWidth = 160.0,
    this.topPadding = 63.0,
    this.bottomPadding = 32.0,
  });

  final String imageAsset;
  final double imageHeight;
  final double imageWidth;
  final double topPadding;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Center(
        child: AppHeaderImage(
          height: imageHeight,
          width: imageWidth,
          imageAsset: imageAsset,
        ),
      ),
    );
  }
}
