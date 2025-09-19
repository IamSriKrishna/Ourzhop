// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// Modern light loading overlay for full-screen loading states
///
/// Provides a clean, minimal loading experience with:
/// - Very light semi-transparent background overlay
/// - Centered loading indicator with built-in CircularProgressIndicator
/// - Optional text message with proper contrast
/// - Clean design that preserves the app's beautiful background
/// - App's primary purple color (#8A38F5) for the loading indicator
class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    this.message,
  });

  /// Optional message to display below the loading indicator
  final String? message;

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;

    return Positioned.fill(
      child: Container(
        color: Colors.white.withValues(alpha: 0.8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Built-in CircularProgressIndicator with app branding
              SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(brandColors.primary),
                  strokeWidth: 4.0,
                ),
              ),

              // Optional message with proper contrast for light overlay
              if (message != null) ...[
                const SizedBox(height: 16.0),
                Text(
                  message!,
                  style: AppFonts.poppins(
                    size: 16.0,
                    weight: FontWeight.w500,
                    color: brandColors.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
