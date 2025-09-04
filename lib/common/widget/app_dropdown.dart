// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/themes/app_colors.dart';

/// Dropdown variants
enum AppDropdownVariant {
  /// Standard dropdown with outline border
  standard,

  /// Filled dropdown with background fill
  filled,

  /// Underlined dropdown with bottom border only
  underlined,
}

/// Reusable dropdown component with theme support
///
/// Automatically adapts to current theme (light/dark) and provides
/// consistent styling across the entire application.
class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.onChanged,
    required this.items,
    this.initialItem,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.validator,
    this.isEnabled = true,
    this.variant = AppDropdownVariant.standard,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.contentPadding,
    this.prefixIcon,
    this.itemBuilder,
    this.displayStringForItem,
  });

  /// Callback when selection changes
  final ValueChanged<T?> onChanged;

  /// List of items to display in dropdown
  final List<T> items;

  /// Initially selected item
  final T? initialItem;

  /// Hint text displayed when no item is selected
  final String? hintText;

  /// Label text displayed above the dropdown
  final String? labelText;

  /// Helper text displayed below the dropdown
  final String? helperText;

  /// Error text displayed below the dropdown
  final String? errorText;

  /// Validator function for form validation
  final FormFieldValidator<T>? validator;

  /// Whether the dropdown is enabled
  final bool isEnabled;

  /// Visual variant of the dropdown
  final AppDropdownVariant variant;

  /// Custom border radius
  final BorderRadius? borderRadius;

  /// Custom fill color
  final Color? fillColor;

  /// Custom border color
  final Color? borderColor;

  /// Custom focused border color
  final Color? focusedBorderColor;

  /// Custom error border color
  final Color? errorBorderColor;

  /// Content padding inside the dropdown
  final EdgeInsetsGeometry? contentPadding;

  /// Icon shown at the beginning of the dropdown
  final Widget? prefixIcon;

  /// Custom item builder for dropdown items
  final Widget Function(T item)? itemBuilder;

  /// Function to get display string for an item
  final String Function(T item)? displayStringForItem;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  T? selectedItem;

  String _getDisplayString(T item) {
    if (widget.displayStringForItem != null) {
      return widget.displayStringForItem!(item);
    }
    if (item.isEnum) return item.getEnumString;
    return item.toString();
  }

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialItem;
  }

  @override
  void didUpdateWidget(AppDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialItem != oldWidget.initialItem) {
      selectedItem = widget.initialItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;

    return DropdownButtonFormField<T>(
      initialValue: selectedItem,
      onChanged: widget.isEnabled ? _onChanged : null,
      validator: widget.validator,
      decoration: _buildInputDecoration(context, theme, brandColors),
      items: widget.items.map(_buildDropdownMenuItem).toList(),
      hint: widget.hintText != null
          ? Text(
              widget.hintText!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: brandColors.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            )
          : null,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: widget.isEnabled
            ? brandColors.onSurface
            : brandColors.onSurfaceVariant,
      ),
      dropdownColor: brandColors.surface,
      iconEnabledColor: brandColors.onSurfaceVariant,
      iconDisabledColor: brandColors.onSurfaceVariant.withValues(alpha: 0.38),
    );
  }

  void _onChanged(T? value) {
    setState(() {
      selectedItem = value;
    });
    widget.onChanged(value);
  }

  DropdownMenuItem<T> _buildDropdownMenuItem(T item) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;

    return DropdownMenuItem<T>(
      value: item,
      child: widget.itemBuilder?.call(item) ??
          Text(
            _getDisplayString(item),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: brandColors.onSurface,
            ),
          ),
    );
  }

  InputDecoration _buildInputDecoration(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
  ) {
    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(8.0);
    final effectiveContentPadding = widget.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    switch (widget.variant) {
      case AppDropdownVariant.standard:
        return InputDecoration(
          labelText: widget.labelText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          contentPadding: effectiveContentPadding,
          filled: false,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: brandColors.onSurfaceVariant,
          ),
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.borderColor ?? brandColors.outline,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.borderColor ?? brandColors.outline,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? brandColors.primary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? brandColors.error,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? brandColors.error,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: brandColors.outlineVariant,
              width: 1.0,
            ),
          ),
        );

      case AppDropdownVariant.filled:
        return InputDecoration(
          labelText: widget.labelText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          contentPadding: effectiveContentPadding,
          filled: true,
          fillColor: widget.fillColor ?? brandColors.surfaceVariant,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: brandColors.onSurfaceVariant,
          ),
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? brandColors.primary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? brandColors.error,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? brandColors.error,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
        );

      case AppDropdownVariant.underlined:
        return InputDecoration(
          labelText: widget.labelText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          contentPadding: effectiveContentPadding,
          filled: false,
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: brandColors.onSurfaceVariant,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? brandColors.outline,
              width: 1.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? brandColors.outline,
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? brandColors.primary,
              width: 2.0,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? brandColors.error,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.errorBorderColor ?? brandColors.error,
              width: 2.0,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: brandColors.outlineVariant,
              width: 1.0,
            ),
          ),
        );
    }
  }
}
