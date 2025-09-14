// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/phone_constants.dart';
import 'package:customer_app/core/models/phone_number.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/auth/presentation/widgets/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneInputFieldTheme {
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color backgroundColor;
  final Color disabledBackgroundColor;
  final double borderWidth;
  final BorderRadius borderRadius;

  const PhoneInputFieldTheme({
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.backgroundColor,
    required this.disabledBackgroundColor,
    this.borderWidth = 1.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  });

  factory PhoneInputFieldTheme.defaultTheme(BuildContext context) {
    final appColors = context.appColors;
    return PhoneInputFieldTheme(
      borderColor: appColors.outline,
      focusedBorderColor: appColors.primary,
      errorBorderColor: Colors.red,
      backgroundColor: appColors.surface,
      disabledBackgroundColor: appColors.surface.withOpacity(0.6),
    );
  }
}

class PhoneInputField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final bool isFocused;
  final bool enabled;
  final PhoneNumber phoneNumber;
  final ValueChanged<String> onCountryChanged;
  final List<String> favoriteCountries;
  final Widget child;
  final double height;
  final TextStyle? labelStyle;
  final PhoneInputFieldTheme? theme;

  const PhoneInputField({
    super.key,
    required this.labelText,
    required this.isFocused,
    required this.phoneNumber,
    required this.onCountryChanged,
    required this.child,
    this.errorText,
    this.enabled = true,
    this.favoriteCountries = PhoneConstants.defaultFavoriteCountries,
    this.height = PhoneConstants.defaultInputHeight,
    this.labelStyle,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final fieldTheme = theme ?? PhoneInputFieldTheme.defaultTheme(context);
    final borderColor = _getBorderColor(fieldTheme);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(context),
        _buildInputContainer(context, fieldTheme, borderColor),
        _buildErrorSection(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    final appColors = context.appColors;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        labelText,
        style: labelStyle ?? _getDefaultLabelStyle(context, appColors),
      ),
    );
  }

  TextStyle _getDefaultLabelStyle(BuildContext context, dynamic appColors) {
    Color labelColor;
    if (errorText != null) {
      labelColor = Colors.red;
    } else if (isFocused) {
      labelColor = appColors.primary;
    } else {
      labelColor = appColors.onSurfaceVariant;
    }

    return AppTypography.getLoginSubtitle(context).copyWith(color: labelColor);
  }

  Widget _buildInputContainer(
    BuildContext context,
    PhoneInputFieldTheme fieldTheme,
    Color borderColor,
  ) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: enabled
            ? fieldTheme.backgroundColor
            : fieldTheme.disabledBackgroundColor,
        border: Border.all(color: borderColor, width: fieldTheme.borderWidth),
        borderRadius: fieldTheme.borderRadius,
      ),
      child: Row(
        children: [
          CountryCodePicker(
            height: height,
            countryCode: phoneNumber.countryCode,
            enabled: enabled,
            favoriteCountries: favoriteCountries,
            onChanged: onCountryChanged,
          ),
          _buildDivider(context),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final appColors = context.appColors;

    return Container(
      height: height * 0.5,
      width: 1.0,
      color: appColors.outline,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
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

  Color _getBorderColor(PhoneInputFieldTheme fieldTheme) {
    if (errorText != null) {
      return fieldTheme.errorBorderColor;
    } else if (isFocused) {
      return fieldTheme.focusedBorderColor;
    } else {
      return fieldTheme.borderColor;
    }
  }
}
