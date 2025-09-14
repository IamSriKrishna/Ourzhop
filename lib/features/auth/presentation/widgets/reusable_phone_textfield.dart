import 'package:customer_app/constants/phone_constants.dart';
import 'package:customer_app/core/formatter/phone_number_formatter.dart';
import 'package:customer_app/core/models/phone_number.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/validation/phone_validation_service.dart';
import 'package:customer_app/features/auth/presentation/widgets/phone_input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextFieldConfig {
  final String labelText;
  final String hintText;
  final List<String> favoriteCountries;
  final String defaultCountryCode;
  final double height;
  final bool autoValidate;
  final bool enabled;
  final InputDecoration? decoration;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;

  const PhoneTextFieldConfig({
    this.labelText = 'Mobile Number',
    this.hintText = PhoneConstants.defaultHintText,
    this.favoriteCountries = PhoneConstants.defaultFavoriteCountries,
    this.defaultCountryCode = PhoneConstants.defaultCountryCode,
    this.height = PhoneConstants.defaultInputHeight,
    this.autoValidate = false,
    this.enabled = true,
    this.decoration,
    this.labelStyle,
    this.textStyle,
  });
}

class ReusablePhoneTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<PhoneNumber>? onPhoneNumberChanged;
  final String? errorText;
  final PhoneTextFieldConfig config;

  const ReusablePhoneTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onPhoneNumberChanged,
    this.errorText,
    this.config = const PhoneTextFieldConfig(),
  });

  @override
  State<ReusablePhoneTextField> createState() => _ReusablePhoneTextFieldState();
}

class _ReusablePhoneTextFieldState extends State<ReusablePhoneTextField> {
  late TextEditingController _internalController;
  late TextEditingController _phoneController;
  late PhoneNumber _phoneNumber;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializePhoneNumber();
    _setupListeners();
  }

  void _initializeControllers() {
    _internalController = TextEditingController();
    _phoneController = TextEditingController();
  }

  void _initializePhoneNumber() {
    final initialText = _effectiveController.text;
    _phoneNumber = PhoneValidationService.parsePhoneNumber(
      initialText,
      defaultCountryCode: widget.config.defaultCountryCode,
    );
    _phoneController.text = _phoneNumber.formattedNumber;
  }

  void _setupListeners() {
    _focusNode.addListener(_handleFocusChange);
    _effectiveController.addListener(_handleControllerChange);
  }

  void _handleFocusChange() {
    setState(() => _isFocused = _focusNode.hasFocus);
  }

  void _handleControllerChange() {
    final expectedText = _phoneNumber.displayNumber;
    if (_effectiveController.text != expectedText) {
      _parseAndUpdatePhoneNumber(_effectiveController.text);
    }
  }

  void _parseAndUpdatePhoneNumber(String fullNumber) {
    final newPhoneNumber = PhoneValidationService.parsePhoneNumber(
      fullNumber,
      defaultCountryCode: widget.config.defaultCountryCode,
    );

    if (newPhoneNumber != _phoneNumber) {
      setState(() {
        _phoneNumber = newPhoneNumber;
        _phoneController.text = _phoneNumber.formattedNumber;
      });
    }
  }

  void _updatePhoneNumber({String? countryCode, String? number}) {
    final newPhoneNumber = _phoneNumber.copyWith(
      countryCode: countryCode,
      number: number,
    );

    if (newPhoneNumber != _phoneNumber) {
      setState(() => _phoneNumber = newPhoneNumber);
      _updateControllers();
      _notifyCallbacks();
    }
  }

  void _updateControllers() {
    final displayNumber = _phoneNumber.displayNumber;
    _phoneController.text = _phoneNumber.formattedNumber;

    if (_effectiveController.text != displayNumber) {
      _effectiveController.value = TextEditingValue(
        text: displayNumber,
        selection: TextSelection.collapsed(offset: displayNumber.length),
      );
    }
  }

  void _notifyCallbacks() {
    widget.onChanged?.call(_phoneNumber.displayNumber);
    widget.onPhoneNumberChanged?.call(_phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return PhoneInputField(
      height: widget.config.height,
      labelText: widget.config.labelText,
      errorText: widget.errorText,
      isFocused: _isFocused,
      enabled: widget.config.enabled,
      phoneNumber: _phoneNumber,
      onCountryChanged: (code) => _updatePhoneNumber(countryCode: code),
      favoriteCountries: widget.config.favoriteCountries,
      labelStyle: widget.config.labelStyle,
      child: _buildPhoneInput(context),
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return TextFormField(
      controller: _phoneController,
      focusNode: _focusNode,
      enabled: widget.config.enabled,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(PhoneConstants.maxPhoneLength),
        PhoneNumberFormatter(),
      ],
      onChanged: _handlePhoneInputChange,
      validator: widget.validator,
      style: widget.config.textStyle ?? _getDefaultTextStyle(theme, appColors),
      decoration: _getInputDecoration(theme, appColors),
    );
  }

  void _handlePhoneInputChange(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    _updatePhoneNumber(number: digitsOnly);

    if (widget.config.autoValidate) {
      _performAutoValidation();
    }
  }

  void _performAutoValidation() {
    final validationResult =
        PhoneValidationService.validatePhoneNumber(_phoneNumber);
  }

  TextStyle _getDefaultTextStyle(ThemeData theme, dynamic appColors) {
    return widget.config.textStyle ??
        theme.textTheme.bodyLarge?.copyWith(color: appColors.onSurface) ??
        const TextStyle();
  }

  InputDecoration _getInputDecoration(ThemeData theme, dynamic appColors) {
    return widget.config.decoration ??
        InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ),
          hintText: widget.config.hintText,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: appColors.onSurfaceVariant.withOpacity(0.6),
          ),
        );
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChange);
    _focusNode.dispose();
    _phoneController.dispose();

    if (widget.controller == null) {
      _internalController.dispose();
    }

    super.dispose();
  }
}
