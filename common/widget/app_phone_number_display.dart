// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// App Phone Number Display Component
///
/// A reusable component that displays a phone number with an edit button.
/// Used in OTP verification and other screens where phone number editing is needed.
class AppPhoneNumberDisplay extends StatelessWidget {
  /// Creates an App Phone Number Display component
  const AppPhoneNumberDisplay({
    super.key,
    required this.phoneNumber,
    this.onEditTapped,
    this.showEditButton = true,
    this.phoneNumberStyle,
  });

  /// The phone number to display
  final String phoneNumber;

  /// Callback when edit button is tapped
  final VoidCallback? onEditTapped;

  /// Whether to show the edit button
  final bool showEditButton;

  /// Custom text style for phone number
  final TextStyle? phoneNumberStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppDesignTokens.spacingSm,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.start, // Changed to start for left alignment
        mainAxisSize: MainAxisSize.min, // Use minimum space needed
        children: [
          Text(
            phoneNumber,
            style: phoneNumberStyle ??
                AppTypography.getPhoneNumberDisplay(
                    context), // Exact design specs
          ),
          if (showEditButton) ...[
            SizedBox(width: AppDesignTokens.spacingMd),
            GestureDetector(
              onTap: onEditTapped,
              child: SizedBox(
                height: 24, // Exact 24px height from design
                width: 24, // Exact 24px width from design
                child: Icon(
                  Icons.edit_outlined,
                  size: 24, // Exact 24px icon size from design
                  color: context.appColors.primary, // Theme-aware primary color
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
