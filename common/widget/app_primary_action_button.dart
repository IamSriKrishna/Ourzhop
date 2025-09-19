// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// Primary action button component for bottom-anchored call-to-action
///
/// This widget provides a consistent button layout for primary actions
/// typically positioned at the bottom of screens. It follows the app's
/// design system with proper theming, typography, and accessibility support.
///
/// Usage:
/// ```dart
/// AppPrimaryActionButton(
///   text: "Continue",
///   onPressed: () => _handleAction(),
///   enabled: true,
/// )
/// ```
class AppPrimaryActionButton extends StatelessWidget {
  const AppPrimaryActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 58.0,
    this.bottomPadding = 20.0,
    this.enabled = true,
  });

  /// Button text label (should be localized)
  final String text;

  /// Button press callback
  final VoidCallback onPressed;

  /// Button height (default: 58.0 for consistency)
  final double height;

  /// Bottom padding (default: 20.0 for bottom positioning)
  final double bottomPadding;

  /// Whether button is enabled
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                enabled ? appColors.primary : appColors.surfaceVariant,
            foregroundColor:
                enabled ? appColors.onPrimary : appColors.onSurfaceVariant,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDesignTokens.borderRadiusLarge),
            ),
            elevation: enabled ? 2 : 0,
            shadowColor: appColors.primary.withValues(alpha: 0.3),
            disabledBackgroundColor: appColors.surfaceVariant,
            disabledForegroundColor: appColors.onSurfaceVariant,
          ),
          child: Text(
            text,
            style: AppTypography.getButtonText(context),
          ),
        ),
      ),
    );
  }
}
