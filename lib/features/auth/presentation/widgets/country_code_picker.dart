// ignore_for_file: deprecated_member_use

import 'package:country_picker/country_picker.dart';
import 'package:customer_app/constants/phone_constants.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:flutter/material.dart';

class CountryCodePicker extends StatelessWidget {
  final String countryCode;
  final bool enabled;
  final List<String> favoriteCountries;
  final ValueChanged<String> onChanged;
  final double? height;
  final TextStyle? textStyle;

  const CountryCodePicker({
    super.key,
    required this.countryCode,
    required this.onChanged,
    this.enabled = true,
    this.favoriteCountries = PhoneConstants.defaultFavoriteCountries,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return InkWell(
      onTap: enabled ? () => _showCountryPicker(context) : null,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
      ),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              countryCode,
              style: textStyle ?? _getDefaultTextStyle(context, enabled),
            ),
            const SizedBox(width: 4.0),
            Icon(
              Icons.keyboard_arrow_down,
              color: enabled
                  ? appColors.primary
                  : appColors.primary.withOpacity(0.5),
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _getDefaultTextStyle(BuildContext context, bool enabled) {
    final appColors = context.appColors;
    return AppTypography.getCountryCodeText(context).copyWith(
      color: enabled ? null : appColors.onSurface.withOpacity(0.5),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: context.appColors.surface,
        textStyle: AppTypography.getCountryCodeText(context),
        searchTextStyle: AppTypography.getCountryCodeText(context),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.7,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      onSelect: (Country country) => onChanged('+${country.phoneCode}'),
      favorite: favoriteCountries,
      showPhoneCode: true,
    );
  }
}
