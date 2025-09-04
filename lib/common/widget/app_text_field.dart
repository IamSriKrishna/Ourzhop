// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// Text field variants
enum AppTextFieldVariant {
  /// Standard text field with outline border
  standard,

  /// Filled text field with background fill
  filled,

  /// Underline text field with bottom border only
  underlined,
}

/// Reusable text field component with Material 3 design and theme support
///
/// Automatically adapts to current theme (light/dark) and provides
/// Material 3 design patterns with design system specifications.
/// Supports floating labels, proper focus states, and error handling.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.validator,
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.contentPadding,
    this.constraints,
    this.variant = AppTextFieldVariant.standard,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.showCursor,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.height,
    this.width,
    this.useMaterial3Design = false,
    this.showExternalError = false,
  });

  /// Initial value for the text field
  final String? initialValue;

  /// Hint text displayed when field is empty
  final String? hintText;

  /// Label text displayed above the field
  final String? labelText;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed below the field
  final String? errorText;

  /// Callback when text changes
  final ValueChanged<String>? onChanged;

  /// Callback when field is tapped
  final VoidCallback? onTap;

  /// Callback when field is submitted
  final ValueChanged<String>? onFieldSubmitted;

  /// Validator function for form validation
  final FormFieldValidator<String>? validator;

  /// Maximum number of lines (null for unlimited)
  final int? maxLines;

  /// Maximum character length
  final int? maxLength;

  /// Minimum number of lines
  final int? minLines;

  /// Text editing controller
  final TextEditingController? controller;

  /// Icon shown at the beginning of the field
  final Widget? prefixIcon;

  /// Icon shown at the end of the field
  final Widget? suffixIcon;

  /// Focus node for managing focus
  final FocusNode? focusNode;

  /// Auto-validation mode
  final AutovalidateMode autovalidateMode;

  /// Keyboard type
  final TextInputType keyboardType;

  /// Input formatters for text processing
  final List<TextInputFormatter>? inputFormatters;

  /// Text style
  final TextStyle? textStyle;

  /// Hint text style
  final TextStyle? hintStyle;

  /// Label text style
  final TextStyle? labelStyle;

  /// Content padding inside the field
  final EdgeInsetsGeometry? contentPadding;

  /// Box constraints for the field
  final BoxConstraints? constraints;

  /// Visual variant of the text field
  final AppTextFieldVariant variant;

  /// Whether the field is enabled
  final bool isEnabled;

  /// Whether the field is read-only
  final bool isReadOnly;

  /// Whether to obscure the text (for passwords)
  final bool obscureText;

  /// Whether to auto-focus on build
  final bool autofocus;

  /// Whether to show cursor
  final bool? showCursor;

  /// Text alignment
  final TextAlign textAlign;

  /// Text capitalization behavior
  final TextCapitalization textCapitalization;

  /// Text input action for keyboard
  final TextInputAction? textInputAction;

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

  /// Custom height for the text field container
  final double? height;

  /// Custom width for the text field container
  final double? width;

  /// Whether to use Material 3 design with floating label
  final bool useMaterial3Design;

  /// Whether to show error externally below the field instead of inside
  final bool showExternalError;

  /// Get Material 3 text style based on design system specifications
  TextStyle _getMaterial3TextStyle(
      BuildContext context, AppColorScheme appColors) {
    return AppTypography.getMobileInputText(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    Widget textField = TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      enabled: isEnabled,
      readOnly: isReadOnly,
      obscureText: obscureText,
      autofocus: autofocus,
      showCursor: showCursor,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      minLines: minLines,
      keyboardType: keyboardType,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      cursorColor: appColors.primary,
      style: textStyle ??
          (useMaterial3Design
              ? _getMaterial3TextStyle(context, appColors)
              : theme.textTheme.bodyLarge?.copyWith(
                  color: isEnabled
                      ? appColors.onSurface
                      : appColors.onSurfaceVariant,
                )),
      decoration: _buildInputDecoration(context, theme, appColors),
    );

    // Apply container dimensions if specified
    if (height != null || width != null) {
      textField = SizedBox(
        height: height,
        width: width,
        child: textField,
      );
    }

    // Handle external error display
    if (showExternalError && errorText != null && errorText!.isNotEmpty) {
      final appColors = context.appColors;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textField,
          const SizedBox(height: 6.0), // Small spacing between field and error
          Padding(
            padding: const EdgeInsets.only(left: 0.0), // Align with field start
            child: Text(
              errorText!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: appColors.error,
                    fontSize: 14.0, // Design font size
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400, // Design font weight
                    height: 1.5, // Design line height
                  ),
            ),
          ),
        ],
      );
    }

    return textField;
  }

  /// Build input decoration based on variant and theme
  InputDecoration _buildInputDecoration(
    BuildContext context,
    ThemeData theme,
    AppColorScheme appColors,
  ) {
    // Material 3 design uses design system specifications
    final effectiveBorderRadius = useMaterial3Design
        ? BorderRadius.circular(10.0) // Design border radius
        : (borderRadius ?? BorderRadius.circular(8.0));

    final effectiveContentPadding = useMaterial3Design
        ? const EdgeInsets.all(20.0) // Design padding: 20 all sides
        : (contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12));

    switch (variant) {
      case AppTextFieldVariant.standard:
        return useMaterial3Design
            ? _buildMaterial3Decoration(context, effectiveBorderRadius,
                effectiveContentPadding, appColors, theme)
            : _buildStandardDecoration(effectiveBorderRadius,
                effectiveContentPadding, appColors, theme);

      case AppTextFieldVariant.filled:
        return InputDecoration(
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          errorText: showExternalError ? null : errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: effectiveContentPadding,
          constraints: constraints,
          filled: true,
          fillColor: fillColor ?? appColors.surfaceVariant,
          hintStyle: hintStyle ??
              theme.textTheme.bodyLarge?.copyWith(
                color: appColors.onSurfaceVariant.withValues(alpha: 0.6),
              ),
          labelStyle: labelStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                color: appColors.onSurfaceVariant,
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
              color: focusedBorderColor ?? appColors.primary,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: errorBorderColor ?? appColors.error,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: errorBorderColor ?? appColors.error,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
        );

      case AppTextFieldVariant.underlined:
        return InputDecoration(
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: effectiveContentPadding,
          constraints: constraints,
          filled: false,
          hintStyle: hintStyle ??
              theme.textTheme.bodyLarge?.copyWith(
                color: appColors.onSurfaceVariant.withValues(alpha: 0.6),
              ),
          labelStyle: labelStyle ??
              theme.textTheme.bodyMedium?.copyWith(
                color: appColors.onSurfaceVariant,
              ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? appColors.outline,
              width: 1.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? appColors.outline,
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: focusedBorderColor ?? appColors.primary,
              width: 2.0,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorBorderColor ?? appColors.error,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorBorderColor ?? appColors.error,
              width: 2.0,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appColors.outlineVariant,
              width: 1.0,
            ),
          ),
        );
    }
  }

  /// Build Material 3 decoration based on design system specifications using theme system
  InputDecoration _buildMaterial3Decoration(
    BuildContext context,
    BorderRadius borderRadius,
    EdgeInsetsGeometry contentPadding,
    AppColorScheme appColors,
    ThemeData theme,
  ) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: showExternalError ? null : errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      constraints: constraints ??
          (height != null
              ? BoxConstraints(
                  minHeight: 56.0, // Fixed minimum height
                  maxHeight: 56.0, // Fixed maximum height
                )
              : null),
      filled: true,
      fillColor: fillColor ?? appColors.surface, // Theme-aware surface color
      hintStyle: hintStyle ?? AppTypography.getMobileInputHint(context),
      labelStyle: labelStyle ?? AppTypography.getMobileInputLabel(context),
      // Material 3 floating label styling with theme awareness
      floatingLabelStyle: AppTypography.getMobileInputLabel(context).copyWith(
        backgroundColor:
            appColors.surface, // Theme-aware background for floating label
      ),
      // Key fix: Use isDense and proper errorMaxLines to prevent height changes
      isDense: true,
      errorMaxLines: 1,
      // Proper error style that doesn't affect field layout
      errorStyle: theme.textTheme.bodySmall?.copyWith(
        color: appColors.error,
        height: 1.2,
      ),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: appColors.primary, // Theme-aware primary color
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: borderColor ?? appColors.primary, // Theme-aware border
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: focusedBorderColor ??
              appColors.primary, // Theme-aware focused border
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: errorBorderColor ?? appColors.error,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: errorBorderColor ?? appColors.error,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: appColors.outline, // Theme-aware outline color
          width: 1.0,
        ),
      ),
    );
  }

  /// Build standard decoration (existing behavior)
  InputDecoration _buildStandardDecoration(
    BorderRadius borderRadius,
    EdgeInsetsGeometry contentPadding,
    AppColorScheme appColors,
    ThemeData theme,
  ) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: showExternalError ? null : errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      constraints: constraints,
      filled: false,
      hintStyle: hintStyle ??
          theme.textTheme.bodyLarge?.copyWith(
            color: appColors.onSurfaceVariant.withValues(alpha: 0.6),
          ),
      labelStyle: labelStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            color: appColors.onSurfaceVariant,
          ),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: borderColor ?? appColors.outline,
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: borderColor ?? appColors.outline,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: focusedBorderColor ?? appColors.primary,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: errorBorderColor ?? appColors.error,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: errorBorderColor ?? appColors.error,
          width: 2.0,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: appColors.outlineVariant,
          width: 1.0,
        ),
      ),
    );
  }
}
