// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:pinput/pinput.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// App OTP Text Field Component
///
/// A reusable OTP input component based on the new design system.
/// Features square/rounded input fields with consistent styling.
class AppOtpTextField extends StatelessWidget {
  /// Creates an App OTP Text Field component
  const AppOtpTextField({
    super.key,
    this.validator,
    this.onChanged,
    this.inputFormatters = const [],
    this.controller,
    this.length = 4,
    this.fieldHeight = 70.0,
    this.fieldWidth = 70.0,
    this.spacing = 20.0,
    this.borderRadius = 10.0,
    this.onCompleted,
  });

  /// Validation function for the OTP
  final FormFieldValidator<String>? validator;

  /// Callback when OTP value changes
  final ValueChanged<String>? onChanged;

  /// Input formatters for the text field
  final List<TextInputFormatter> inputFormatters;

  /// Text controller for the OTP field
  final TextEditingController? controller;

  /// Number of OTP digits
  final int length;

  /// Height of each OTP field
  final double fieldHeight;

  /// Width of each OTP field
  final double fieldWidth;

  /// Spacing between OTP fields
  final double spacing;

  /// Border radius of OTP fields
  final double borderRadius;

  /// Callback when OTP is completed
  final ValueChanged<String>? onCompleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Pinput(
      length: length,
      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      onCompleted: onCompleted,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      // Default/Empty state styling
      defaultPinTheme: PinTheme(
        height: fieldHeight,
        width: fieldWidth,
        textStyle: AppTypography.getOtpInputText(context).copyWith(
          color: theme
              .colorScheme.onSurfaceVariant, // Use theme color for empty state
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? theme.colorScheme.outline
                : AppColors.otpBorderGray, // #CFD1D3 from design
            width: 1.0,
          ),
        ),
      ),

      // Focused state styling
      focusedPinTheme: PinTheme(
        height: fieldHeight,
        width: fieldWidth,
        textStyle: AppTypography.getOtpInputText(context),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.colorScheme.primary,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),

      // Submitted/Filled state styling
      submittedPinTheme: PinTheme(
        height: fieldHeight,
        width: fieldWidth,
        textStyle: AppTypography.getOtpInputText(context),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
      ),

      // Error state styling
      errorPinTheme: PinTheme(
        height: fieldHeight,
        width: fieldWidth,
        textStyle: AppTypography.getOtpInputText(context).copyWith(
          color: theme.colorScheme.error, // Override color for error state
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.colorScheme.error,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.error.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
