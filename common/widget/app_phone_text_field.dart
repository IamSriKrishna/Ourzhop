// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:customer_app/constants/phone_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// Indian phone number input widget with Indian country code
///
/// This widget provides a specialized phone input for Indian numbers with:
/// - Fixed Indian country code prefix (non-editable)
/// - Exactly 10 digit input validation
/// - Material 3 design with theme support
/// - Clean visual separation between country code and number
/// - Pure StatelessWidget for optimal BLoC integration
/// - Parent-managed controller and focus node for stability
class AppPhoneTextField extends StatelessWidget {
  const AppPhoneTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.labelText = 'Mobile Number',
    this.hintText = '0000000000',
    this.errorText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.autofocus = false,
    this.height = 56.0,
  });

  /// Text editing controller for the 10-digit number input (REQUIRED)
  final TextEditingController controller;

  /// Focus node for the input field (REQUIRED)
  final FocusNode focusNode;

  /// Label text displayed above the field
  final String labelText;

  /// Hint text displayed in the number input area
  final String hintText;

  /// Error text displayed below the field
  final String? errorText;

  /// Callback when the 10-digit number changes
  final ValueChanged<String>? onChanged;

  /// Validator function for form validation
  final FormFieldValidator<String>? validator;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether to auto-focus on build
  final bool autofocus;

  /// Height of the input field container
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(context),
        const SizedBox(height: 8.0),
        _buildPhoneInputContainer(context),
        _buildErrorSection(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    final appColors = context.appColors;

    // Handle error state without reactive focus
    if (errorText != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Text(
          labelText,
          style: AppTypography.getLoginSubtitle(context).copyWith(
            color: appColors.error,
          ),
        ),
      );
    }

    // Use ListenableBuilder for reactive focus state
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, _) {
        final isFocused = focusNode.hasFocus;
        final labelColor =
            isFocused ? appColors.primary : appColors.onSurfaceVariant;

        return Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            labelText,
            style: AppTypography.getLoginSubtitle(context).copyWith(
              color: labelColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneInputContainer(BuildContext context) {
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, _) {
        final isFocused = focusNode.hasFocus;
        final appColors = context.appColors;
        final borderColor = _getBorderColor(appColors, isFocused);
        final borderWidth = _getBorderWidth(isFocused);

        return Container(
          height: height,
          decoration: BoxDecoration(
            color: enabled
                ? appColors.surface
                : appColors.surface.withValues(alpha: 0.6),
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              _buildCountryCodeSection(context, appColors, isFocused),
              _buildDivider(appColors, isFocused),
              Expanded(child: _buildPhoneNumberInput(context, appColors)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryCodeSection(
      BuildContext context, AppColorScheme appColors, bool isFocused) {
    final countryCodeColor = enabled
        ? (isFocused ? appColors.primary : appColors.onSurface)
        : appColors.onSurfaceVariant.withValues(alpha: 0.6);

    final backgroundColor = isFocused
        ? appColors.primaryContainer.withValues(alpha: 0.1)
        : appColors.surface;

    return Container(
      width: 70.0,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          PhoneConstants.defaultCountryCode,
          style: AppTypography.getMobileInputText(context).copyWith(
            color: countryCodeColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(AppColorScheme appColors, bool isFocused) {
    final dividerColor = isFocused
        ? appColors.primary.withValues(alpha: 0.4)
        : appColors.outline;

    return Container(
      height: height * 0.6,
      width: 1.5,
      decoration: BoxDecoration(
        color: dividerColor,
        borderRadius: BorderRadius.circular(1.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }

  Widget _buildPhoneNumberInput(
      BuildContext context, AppColorScheme appColors) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(PhoneConstants.exactPhoneLength),
      ],
      validator: validator ?? _defaultValidator,
      onChanged: onChanged,
      style: AppTypography.getMobileInputText(context).copyWith(
        color: enabled
            ? appColors.onSurface
            : appColors.onSurfaceVariant.withValues(alpha: 0.6),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 16.0,
        ),
        hintText: hintText,
        hintStyle: AppTypography.getMobileInputHint(context),
      ),
    );
  }

  Widget _buildErrorSection(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: errorText != null
          ? Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 4.0),
              child: Text(
                errorText!,
                style: AppTypography.getErrorText(context),
              ),
            )
          : null,
    );
  }

  Color _getBorderColor(AppColorScheme appColors, bool isFocused) {
    if (errorText != null) {
      return appColors.error;
    } else if (isFocused) {
      return appColors.primary;
    } else {
      return appColors.outline;
    }
  }

  double _getBorderWidth(bool isFocused) {
    if (errorText != null) {
      return 2.0;
    } else if (isFocused) {
      return 2.0;
    } else {
      return 1.0;
    }
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    if (value.length != PhoneConstants.exactPhoneLength) {
      return 'Phone number must be exactly ${PhoneConstants.exactPhoneLength} digits';
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Phone number must contain only digits';
    }

    return null;
  }
}
