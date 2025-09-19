// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'app_divider.dart';
import 'app_dropdown.dart';
import 'app_text_field.dart';

/// Extension on BuildContext for easy widget access
extension AppWidgetExtensions on BuildContext {
  /// Get current theme brand colors
  AppColorScheme get colors => appColors;

  /// Quick access to themed button variants
  Widget primaryButton({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
    AppButtonSize size = AppButtonSize.medium,
  }) =>
      AppButton(
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.primary,
        icon: icon,
        isLoading: isLoading,
        fullWidth: fullWidth,
        size: size,
      );

  /// Quick access to secondary button
  Widget secondaryButton({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
    AppButtonSize size = AppButtonSize.medium,
  }) =>
      AppButton(
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.secondary,
        icon: icon,
        isLoading: isLoading,
        fullWidth: fullWidth,
        size: size,
      );

  /// Quick access to success button
  Widget successButton({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
    AppButtonSize size = AppButtonSize.medium,
  }) =>
      AppButton(
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.success,
        icon: icon,
        isLoading: isLoading,
        fullWidth: fullWidth,
        size: size,
      );

  /// Quick access to error button
  Widget errorButton({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    bool isLoading = false,
    bool fullWidth = false,
    AppButtonSize size = AppButtonSize.medium,
  }) =>
      AppButton(
        onPressed: onPressed,
        label: label,
        variant: AppButtonVariant.error,
        icon: icon,
        isLoading: isLoading,
        fullWidth: fullWidth,
        size: size,
      );

  /// Quick access to text field
  Widget textField({
    TextEditingController? controller,
    String? labelText,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    bool obscureText = false,
    AppTextFieldVariant variant = AppTextFieldVariant.standard,
    bool isEnabled = true,
  }) =>
      AppTextField(
        controller: controller,
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        variant: variant,
        isEnabled: isEnabled,
      );

  /// Quick access to standard card
  Widget card({
    required Widget child,
    VoidCallback? onTap,
    AppCardSize size = AppCardSize.medium,
    AppCardVariant variant = AppCardVariant.standard,
  }) =>
      AppCard(
        onTap: onTap,
        size: size,
        variant: variant,
        child: child,
      );

  /// Quick access to list card
  Widget listCard({
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    bool isSelected = false,
    AppCardSize size = AppCardSize.medium,
  }) =>
      AppListCard(
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        isSelected: isSelected,
        size: size,
      );

  /// Quick access to action card
  Widget actionCard({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    bool isEnabled = true,
    AppCardSize size = AppCardSize.medium,
  }) =>
      AppActionCard(
        icon: icon,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
        isEnabled: isEnabled,
        size: size,
      );

  /// Quick access to horizontal divider
  Widget divider({
    Color? color,
    double thickness = 1.0,
    double indent = 0,
    double endIndent = 0,
  }) =>
      AppDivider(
        color: color,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      );

  /// Quick access to text divider
  Widget textDivider({
    required String text,
    Color? color,
    Color? textColor,
    double thickness = 1.0,
  }) =>
      AppTextDivider(
        text: text,
        color: color,
        textColor: textColor,
        thickness: thickness,
      );

  /// Quick access to dropdown
  Widget dropdown<T>({
    required ValueChanged<T?> onChanged,
    required List<T> items,
    T? initialItem,
    String? hintText,
    String? labelText,
    FormFieldValidator<T>? validator,
    AppDropdownVariant variant = AppDropdownVariant.standard,
    String Function(T item)? displayStringForItem,
  }) =>
      AppDropdown<T>(
        onChanged: onChanged,
        items: items,
        initialItem: initialItem,
        hintText: hintText,
        labelText: labelText,
        validator: validator,
        variant: variant,
        displayStringForItem: displayStringForItem,
      );
}

/// Helper widget for consistent spacing using theme values
class AppSpacing extends StatelessWidget {
  const AppSpacing.small({super.key}) : size = AppSpacingSize.small;
  const AppSpacing.medium({super.key}) : size = AppSpacingSize.medium;
  const AppSpacing.large({super.key}) : size = AppSpacingSize.large;
  const AppSpacing.extraLarge({super.key}) : size = AppSpacingSize.extraLarge;

  final AppSpacingSize size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getSize(),
      height: _getSize(),
    );
  }

  double _getSize() {
    switch (size) {
      case AppSpacingSize.small:
        return 8.0;
      case AppSpacingSize.medium:
        return 16.0;
      case AppSpacingSize.large:
        return 24.0;
      case AppSpacingSize.extraLarge:
        return 32.0;
    }
  }
}

/// Spacing size enum
enum AppSpacingSize { small, medium, large, extraLarge }

/// Helper widget for consistent padding using theme values
class AppPadding extends StatelessWidget {
  const AppPadding.small({
    super.key,
    required this.child,
  }) : size = AppPaddingSize.small;

  const AppPadding.medium({
    super.key,
    required this.child,
  }) : size = AppPaddingSize.medium;

  const AppPadding.large({
    super.key,
    required this.child,
  }) : size = AppPaddingSize.large;

  const AppPadding.extraLarge({
    super.key,
    required this.child,
  }) : size = AppPaddingSize.extraLarge;

  final Widget child;
  final AppPaddingSize size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_getPadding()),
      child: child,
    );
  }

  double _getPadding() {
    switch (size) {
      case AppPaddingSize.small:
        return 8.0;
      case AppPaddingSize.medium:
        return 16.0;
      case AppPaddingSize.large:
        return 24.0;
      case AppPaddingSize.extraLarge:
        return 32.0;
    }
  }
}

/// Padding size enum
enum AppPaddingSize { small, medium, large, extraLarge }

/// Helper for creating consistent border radius
class AppBorderRadius {
  const AppBorderRadius._();

  /// Small border radius - 4px
  static BorderRadius get small => BorderRadius.circular(4.0);

  /// Medium border radius - 8px
  static BorderRadius get medium => BorderRadius.circular(8.0);

  /// Large border radius - 12px
  static BorderRadius get large => BorderRadius.circular(12.0);

  /// Extra large border radius - 16px
  static BorderRadius get extraLarge => BorderRadius.circular(16.0);

  /// Pill border radius - 100px (for buttons)
  static BorderRadius get pill => BorderRadius.circular(100.0);

  /// Top border radius
  static BorderRadius top(double radius) => BorderRadius.vertical(
        top: Radius.circular(radius),
      );

  /// Bottom border radius
  static BorderRadius bottom(double radius) => BorderRadius.vertical(
        bottom: Radius.circular(radius),
      );

  /// Left border radius
  static BorderRadius left(double radius) => BorderRadius.horizontal(
        left: Radius.circular(radius),
      );

  /// Right border radius
  static BorderRadius right(double radius) => BorderRadius.horizontal(
        right: Radius.circular(radius),
      );
}

/// Extension to access border radius from context
extension AppBorderRadiusExtension on BuildContext {
  /// Get app border radius helper
  AppBorderRadius get borderRadius => const AppBorderRadius._();
}

/// Common loading states helper
class AppLoadingStates {
  const AppLoadingStates._();

  /// Standard loading indicator with brand colors
  static Widget loadingIndicator(BuildContext context, {Color? color}) {
    final appColors = context.appColors;
    return CircularProgressIndicator(
      color: color ?? appColors.primary,
      strokeWidth: 2.0,
    );
  }

  /// Small loading indicator
  static Widget smallLoadingIndicator(BuildContext context, {Color? color}) {
    final appColors = context.appColors;
    return SizedBox(
      width: 16.0,
      height: 16.0,
      child: CircularProgressIndicator(
        color: color ?? appColors.primary,
        strokeWidth: 1.5,
      ),
    );
  }

  /// Loading overlay
  static Widget loadingOverlay(BuildContext context, {String? message}) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return Container(
      color: appColors.surface.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            loadingIndicator(context),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: appColors.onSurface,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Extension for easy loading state access
extension AppLoadingExtension on BuildContext {
  /// Get loading helper
  AppLoadingStates get loading => const AppLoadingStates._();
}
