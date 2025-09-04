// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

/// Card variants
enum AppCardVariant {
  /// Standard card with default elevation
  standard,

  /// Elevated card with higher elevation
  elevated,

  /// Outlined card with border instead of elevation
  outlined,

  /// Filled card with background color
  filled,
}

/// Card sizes providing consistent spacing
enum AppCardSize {
  /// Small card - minimal padding
  small,

  /// Medium card - standard padding (default)
  medium,

  /// Large card - generous padding
  large,
}

/// Reusable card component with theme support
///
/// Automatically adapts to current theme (light/dark) and provides
/// consistent styling and spacing across the entire application.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.variant = AppCardVariant.standard,
    this.size = AppCardSize.medium,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.borderColor,
    this.borderWidth,
    this.width,
    this.height,
    this.constraints,
    this.clipBehavior = Clip.antiAlias,
  });

  /// Child widget displayed inside the card
  final Widget child;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  /// Callback when card is long pressed
  final VoidCallback? onLongPress;

  /// Visual variant of the card
  final AppCardVariant variant;

  /// Size/padding variant of the card
  final AppCardSize size;

  /// External margin around the card
  final EdgeInsetsGeometry? margin;

  /// Border radius of the card
  final BorderRadius? borderRadius;

  /// Background color of the card
  final Color? backgroundColor;

  /// Elevation of the card (shadow depth)
  final double? elevation;

  /// Shadow color of the card
  final Color? shadowColor;

  /// Border color for outlined variant
  final Color? borderColor;

  /// Border width for outlined variant
  final double? borderWidth;

  /// Fixed width of the card
  final double? width;

  /// Fixed height of the card
  final double? height;

  /// Size constraints for the card
  final BoxConstraints? constraints;

  /// Clip behavior for the card content
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;
    final isInteractive = onTap != null || onLongPress != null;

    return Container(
      width: width,
      height: height,
      margin: margin ?? _getDefaultMargin(),
      constraints: constraints,
      child: Material(
        color: _getBackgroundColor(brandColors),
        elevation: _getElevation(),
        shadowColor: _getShadowColor(brandColors),
        borderRadius: _getBorderRadius(),
        clipBehavior: clipBehavior,
        child: _buildCard(context, theme, brandColors, isInteractive),
      ),
    );
  }

  /// Build the card content
  Widget _buildCard(
    BuildContext context,
    ThemeData theme,
    AppColorScheme brandColors,
    bool isInteractive,
  ) {
    Widget cardContent = Container(
      decoration: _getDecoration(brandColors),
      padding: _getPadding(),
      child: child,
    );

    if (isInteractive) {
      cardContent = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: _getBorderRadius(),
        splashColor: brandColors.primary.withValues(alpha: 0.1),
        highlightColor: brandColors.primary.withValues(alpha: 0.05),
        child: cardContent,
      );
    }

    return cardContent;
  }

  /// Get background color based on variant
  Color _getBackgroundColor(AppColorScheme brandColors) {
    if (backgroundColor != null) return backgroundColor!;

    switch (variant) {
      case AppCardVariant.standard:
        return brandColors.surface;
      case AppCardVariant.elevated:
        return brandColors.surface;
      case AppCardVariant.outlined:
        return Colors.transparent;
      case AppCardVariant.filled:
        return brandColors.surfaceVariant;
    }
  }

  /// Get elevation based on variant
  double _getElevation() {
    if (elevation != null) return elevation!;

    switch (variant) {
      case AppCardVariant.standard:
        return 2.0;
      case AppCardVariant.elevated:
        return 8.0;
      case AppCardVariant.outlined:
        return 0.0;
      case AppCardVariant.filled:
        return 1.0;
    }
  }

  /// Get shadow color
  Color? _getShadowColor(AppColorScheme brandColors) {
    if (shadowColor != null) return shadowColor!;

    switch (variant) {
      case AppCardVariant.standard:
        return brandColors.outline.withValues(alpha: 0.2);
      case AppCardVariant.elevated:
        return brandColors.outline.withValues(alpha: 0.3);
      case AppCardVariant.outlined:
        return null;
      case AppCardVariant.filled:
        return brandColors.outline.withValues(alpha: 0.1);
    }
  }

  /// Get border radius
  BorderRadius _getBorderRadius() {
    return borderRadius ?? BorderRadius.circular(12.0);
  }

  /// Get container decoration for outlined variant
  BoxDecoration? _getDecoration(AppColorScheme brandColors) {
    if (variant != AppCardVariant.outlined) return null;

    return BoxDecoration(
      border: Border.all(
        color: borderColor ?? brandColors.outline,
        width: borderWidth ?? 1.0,
      ),
      borderRadius: _getBorderRadius(),
    );
  }

  /// Get padding based on size
  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case AppCardSize.small:
        return const EdgeInsets.all(12.0);
      case AppCardSize.medium:
        return const EdgeInsets.all(16.0);
      case AppCardSize.large:
        return const EdgeInsets.all(24.0);
    }
  }

  /// Get default margin
  EdgeInsetsGeometry _getDefaultMargin() {
    switch (size) {
      case AppCardSize.small:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      case AppCardSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
      case AppCardSize.large:
        return const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
    }
  }
}

/// Specialized card for list items
class AppListCard extends StatelessWidget {
  const AppListCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.size = AppCardSize.medium,
    this.showDivider = false,
    this.isSelected = false,
  });

  /// Primary title text
  final String title;

  /// Optional subtitle text
  final String? subtitle;

  /// Leading widget (usually icon or avatar)
  final Widget? leading;

  /// Trailing widget (usually icon or action)
  final Widget? trailing;

  /// Tap callback
  final VoidCallback? onTap;

  /// Long press callback
  final VoidCallback? onLongPress;

  /// Card size
  final AppCardSize size;

  /// Whether to show bottom divider
  final bool showDivider;

  /// Whether the item is selected
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;

    return AppCard(
      onTap: onTap,
      onLongPress: onLongPress,
      size: size,
      backgroundColor: isSelected ? brandColors.primaryContainer : null,
      child: Column(
        children: [
          Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isSelected
                            ? brandColors.onPrimaryContainer
                            : brandColors.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? brandColors.onPrimaryContainer
                                  .withValues(alpha: 0.7)
                              : brandColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 16),
                trailing!,
              ],
            ],
          ),
          if (showDivider) ...[
            const SizedBox(height: 16),
            Divider(
              height: 1,
              color: brandColors.outlineVariant,
            ),
          ],
        ],
      ),
    );
  }
}

/// Card specifically for actions/buttons
class AppActionCard extends StatelessWidget {
  const AppActionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.size = AppCardSize.medium,
    this.variant = AppCardVariant.standard,
    this.iconColor,
    this.isEnabled = true,
  });

  /// Icon for the action
  final IconData icon;

  /// Title of the action
  final String title;

  /// Optional subtitle
  final String? subtitle;

  /// Tap callback
  final VoidCallback onTap;

  /// Card size
  final AppCardSize size;

  /// Card variant
  final AppCardVariant variant;

  /// Custom icon color
  final Color? iconColor;

  /// Whether the action is enabled
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColors = context.appColors;

    return AppCard(
      onTap: isEnabled ? onTap : null,
      size: size,
      variant: variant,
      child: Row(
        children: [
          Icon(
            icon,
            color: isEnabled
                ? (iconColor ?? brandColors.primary)
                : brandColors.onSurfaceVariant,
            size: _getIconSize(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isEnabled
                        ? brandColors.onSurface
                        : brandColors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isEnabled
                          ? brandColors.onSurfaceVariant
                          : brandColors.onSurfaceVariant.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: isEnabled
                ? brandColors.onSurfaceVariant
                : brandColors.onSurfaceVariant.withValues(alpha: 0.5),
            size: 16,
          ),
        ],
      ),
    );
  }

  /// Get icon size based on card size
  double _getIconSize() {
    switch (size) {
      case AppCardSize.small:
        return 20.0;
      case AppCardSize.medium:
        return 24.0;
      case AppCardSize.large:
        return 28.0;
    }
  }
}
