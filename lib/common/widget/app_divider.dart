// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

/// Reusable divider component with theme support
///
/// Automatically adapts to current theme (light/dark) and provides
/// consistent styling across the entire application.
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.color,
    this.thickness,
    this.indent = 0,
    this.endIndent = 0,
    this.height,
  });

  /// Color of the divider line
  final Color? color;

  /// Thickness of the divider line
  final double? thickness;

  /// Left indent of the divider
  final double indent;

  /// Right indent of the divider
  final double endIndent;

  /// Height of the divider (including space above and below)
  final double? height;

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;

    return Divider(
      color: color ?? brandColors.outlineVariant,
      thickness: thickness ?? 1.0,
      indent: indent,
      endIndent: endIndent,
      height: height ?? 1.0,
    );
  }
}

/// Vertical divider component with theme support
class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({
    super.key,
    this.color,
    this.thickness,
    this.indent = 0,
    this.endIndent = 0,
    this.width,
  });

  /// Color of the divider line
  final Color? color;

  /// Thickness of the divider line
  final double? thickness;

  /// Top indent of the divider
  final double indent;

  /// Bottom indent of the divider
  final double endIndent;

  /// Width of the divider (including space left and right)
  final double? width;

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;

    return VerticalDivider(
      color: color ?? brandColors.outlineVariant,
      thickness: thickness ?? 1.0,
      indent: indent,
      endIndent: endIndent,
      width: width ?? 1.0,
    );
  }
}

/// Divider with text in the center
class AppTextDivider extends StatelessWidget {
  const AppTextDivider({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.textStyle,
    this.thickness,
    this.indent = 16,
    this.endIndent = 16,
  });

  /// Text to display in the center of the divider
  final String text;

  /// Color of the divider line
  final Color? color;

  /// Color of the text
  final Color? textColor;

  /// Style of the text
  final TextStyle? textStyle;

  /// Thickness of the divider line
  final double? thickness;

  /// Left indent of the divider
  final double indent;

  /// Right indent of the divider
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;

    return Row(
      children: [
        if (indent > 0) SizedBox(width: indent),
        Expanded(
          child: AppDivider(
            color: color,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: textStyle ??
                theme.textTheme.bodySmall?.copyWith(
                  color: textColor ?? brandColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          child: AppDivider(
            color: color,
            thickness: thickness,
          ),
        ),
        if (endIndent > 0) SizedBox(width: endIndent),
      ],
    );
  }
}

/// Divider with icon in the center
class AppIconDivider extends StatelessWidget {
  const AppIconDivider({
    super.key,
    required this.icon,
    this.color,
    this.iconColor,
    this.iconSize,
    this.thickness,
    this.indent = 16,
    this.endIndent = 16,
  });

  /// Icon to display in the center of the divider
  final IconData icon;

  /// Color of the divider line
  final Color? color;

  /// Color of the icon
  final Color? iconColor;

  /// Size of the icon
  final double? iconSize;

  /// Thickness of the divider line
  final double? thickness;

  /// Left indent of the divider
  final double indent;

  /// Right indent of the divider
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;

    return Row(
      children: [
        if (indent > 0) SizedBox(width: indent),
        Expanded(
          child: AppDivider(
            color: color,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            icon,
            color: iconColor ?? brandColors.onSurfaceVariant,
            size: iconSize ?? 20,
          ),
        ),
        Expanded(
          child: AppDivider(
            color: color,
            thickness: thickness,
          ),
        ),
        if (endIndent > 0) SizedBox(width: endIndent),
      ],
    );
  }
}
