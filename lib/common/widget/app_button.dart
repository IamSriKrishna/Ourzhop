// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

/// Button variants following Material 3 design patterns
enum AppButtonVariant {
  /// Primary button - main call-to-action
  primary,

  /// Secondary button - supporting actions
  secondary,

  /// Tertiary button - low-emphasis actions
  tertiary,

  /// Success button - positive confirmations
  success,

  /// Warning button - caution actions
  warning,

  /// Error/Danger button - destructive actions
  error,
}

/// Button sizes
enum AppButtonSize {
  /// Small button - 32px height
  small,

  /// Medium button - 48px height (default)
  medium,

  /// Large button - 56px height
  large,
}

/// Reusable button component with theme support
///
/// Automatically adapts to current theme (light/dark) and provides
/// consistent styling across the entire application.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isEnabled = true,
    this.fullWidth = false,
    this.borderRadius,
  });

  /// Button press callback
  final VoidCallback? onPressed;

  /// Button text label
  final String label;

  /// Visual variant of the button
  final AppButtonVariant variant;

  /// Size of the button
  final AppButtonSize size;

  /// Optional leading icon
  final IconData? icon;

  /// Whether button is in loading state
  final bool isLoading;

  /// Whether button is enabled
  final bool isEnabled;

  /// Whether button should take full width of container
  final bool fullWidth;

  /// Custom border radius (overrides default)
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;

    final isDisabled = !isEnabled || isLoading || onPressed == null;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: _getHeight(),
      child: _buildButton(context, theme, brandColors, isDisabled),
    );
  }

  /// Get button height based on size
  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32.0;
      case AppButtonSize.medium:
        return 48.0;
      case AppButtonSize.large:
        return 56.0;
    }
  }

  /// Build button based on variant
  Widget _buildButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    switch (variant) {
      case AppButtonVariant.primary:
        return _buildElevatedButton(context, theme, brandColors, isDisabled);
      case AppButtonVariant.secondary:
        return _buildOutlinedButton(context, theme, brandColors, isDisabled);
      case AppButtonVariant.tertiary:
        return _buildTextButton(context, theme, brandColors, isDisabled);
      case AppButtonVariant.success:
        return _buildSuccessButton(context, theme, brandColors, isDisabled);
      case AppButtonVariant.warning:
        return _buildWarningButton(context, theme, brandColors, isDisabled);
      case AppButtonVariant.error:
        return _buildErrorButton(context, theme, brandColors, isDisabled);
    }
  }

  /// Build primary elevated button
  Widget _buildElevatedButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    if (icon != null || isLoading) {
      return ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: _buildIcon(brandColors.onPrimary, isDisabled),
        label: _buildLabel(context, brandColors.onPrimary, isDisabled),
        style: _getElevatedButtonStyle(brandColors, isDisabled,
            brandColors.primary, brandColors.onPrimary),
      );
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: _getElevatedButtonStyle(
          brandColors, isDisabled, brandColors.primary, brandColors.onPrimary),
      child: _buildLabel(context, brandColors.onPrimary, isDisabled),
    );
  }

  /// Build secondary outlined button
  Widget _buildOutlinedButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    final borderColor =
        isDisabled ? brandColors.outlineVariant : brandColors.primary;
    final foregroundColor =
        isDisabled ? brandColors.onSurfaceVariant : brandColors.primary;

    if (icon != null || isLoading) {
      return OutlinedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: _buildIcon(foregroundColor, isDisabled),
        label: _buildLabel(context, foregroundColor, isDisabled),
        style: _getOutlinedButtonStyle(
            brandColors, isDisabled, borderColor, foregroundColor),
      );
    }

    return OutlinedButton(
      onPressed: isDisabled ? null : onPressed,
      style: _getOutlinedButtonStyle(
          brandColors, isDisabled, borderColor, foregroundColor),
      child: _buildLabel(context, foregroundColor, isDisabled),
    );
  }

  /// Build tertiary text button
  Widget _buildTextButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    final foregroundColor =
        isDisabled ? brandColors.onSurfaceVariant : brandColors.primary;

    if (icon != null || isLoading) {
      return TextButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: _buildIcon(foregroundColor, isDisabled),
        label: _buildLabel(context, foregroundColor, isDisabled),
        style: _getTextButtonStyle(brandColors, isDisabled, foregroundColor),
      );
    }

    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: _getTextButtonStyle(brandColors, isDisabled, foregroundColor),
      child: _buildLabel(context, foregroundColor, isDisabled),
    );
  }

  /// Build success variant button
  Widget _buildSuccessButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    if (icon != null || isLoading) {
      return ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: _buildIcon(brandColors.onSuccess, isDisabled),
        label: _buildLabel(context, brandColors.onSuccess, isDisabled),
        style: _getElevatedButtonStyle(brandColors, isDisabled,
            brandColors.success, brandColors.onSuccess),
      );
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: _getElevatedButtonStyle(
          brandColors, isDisabled, brandColors.success, brandColors.onSuccess),
      child: _buildLabel(context, brandColors.onSuccess, isDisabled),
    );
  }

  /// Build warning variant button
  Widget _buildWarningButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    if (icon != null || isLoading) {
      return ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: _buildIcon(brandColors.onWarning, isDisabled),
        label: _buildLabel(context, brandColors.onWarning, isDisabled),
        style: _getElevatedButtonStyle(brandColors, isDisabled,
            brandColors.warning, brandColors.onWarning),
      );
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: _getElevatedButtonStyle(
          brandColors, isDisabled, brandColors.warning, brandColors.onWarning),
      child: _buildLabel(context, brandColors.onWarning, isDisabled),
    );
  }

  /// Build error/danger variant button
  Widget _buildErrorButton(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isDisabled,
  ) {
    if (icon != null || isLoading) {
      return ElevatedButton.icon(
        onPressed: isDisabled ? null : onPressed,
        icon: _buildIcon(brandColors.onError, isDisabled),
        label: _buildLabel(context, brandColors.onError, isDisabled),
        style: _getElevatedButtonStyle(
            brandColors, isDisabled, brandColors.error, brandColors.onError),
      );
    }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: _getElevatedButtonStyle(
          brandColors, isDisabled, brandColors.error, brandColors.onError),
      child: _buildLabel(context, brandColors.onError, isDisabled),
    );
  }

  /// Get elevated button style
  ButtonStyle _getElevatedButtonStyle(
    AppColorScheme brandColors,
    bool isDisabled,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    return ElevatedButton.styleFrom(
      backgroundColor:
          isDisabled ? brandColors.surfaceVariant : backgroundColor,
      foregroundColor:
          isDisabled ? brandColors.onSurfaceVariant : foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(100),
      ),
      elevation: isDisabled ? 0 : 2,
      shadowColor: backgroundColor.withValues(alpha: 0.3),
      textStyle: _getTextStyle(),
      padding: _getPadding(),
    );
  }

  /// Get outlined button style
  ButtonStyle _getOutlinedButtonStyle(
    AppColorScheme brandColors,
    bool isDisabled,
    Color borderColor,
    Color foregroundColor,
  ) {
    return OutlinedButton.styleFrom(
      foregroundColor: foregroundColor,
      side: BorderSide(color: borderColor, width: isDisabled ? 1 : 2),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(100),
      ),
      textStyle: _getTextStyle(),
      padding: _getPadding(),
    );
  }

  /// Get text button style
  ButtonStyle _getTextButtonStyle(
    AppColorScheme brandColors,
    bool isDisabled,
    Color foregroundColor,
  ) {
    return TextButton.styleFrom(
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
      ),
      textStyle: _getTextStyle(),
      padding: _getPadding(),
    );
  }

  /// Build button icon
  Widget _buildIcon(Color color, bool isDisabled) {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      );
    }

    if (icon != null) {
      return Icon(
        icon,
        size: _getIconSize(),
        color: color,
      );
    }

    return const SizedBox.shrink();
  }

  /// Build button label
  Widget _buildLabel(BuildContext context, Color color, bool isDisabled) {
    return Text(
      label,
      style: _getTextStyle().copyWith(
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Get text style based on size
  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return const TextStyle(fontSize: 12);
      case AppButtonSize.medium:
        return const TextStyle(fontSize: 16);
      case AppButtonSize.large:
        return const TextStyle(fontSize: 18);
    }
  }

  /// Get icon size based on button size
  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16.0;
      case AppButtonSize.medium:
        return 20.0;
      case AppButtonSize.large:
        return 24.0;
    }
  }

  /// Get padding based on size
  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 4);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }
}
