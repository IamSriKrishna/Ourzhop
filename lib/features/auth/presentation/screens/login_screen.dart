import 'package:country_picker/country_picker.dart';
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_header_image.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PhoneValidationService {
  static const Map<String, PhoneValidationRule> _validationRules = {
    '+91': PhoneValidationRule(
      length: 10,
      pattern: r'^[6-9][0-9]{9}$',
      errorMessage: 'Please enter a valid 10-digit mobile number',
    ),
    '+1': PhoneValidationRule(
      length: 10,
      pattern: r'^[2-9][0-9]{9}$',
      errorMessage: 'Please enter a valid 10-digit phone number',
    ),
    '+44': PhoneValidationRule(
      minLength: 10,
      maxLength: 11,
      pattern: r'^[1-9][0-9]{9,10}$',
      errorMessage: 'Please enter a valid UK phone number',
    ),
  };

  static String? validatePhoneNumber(String phoneNumber, String countryCode) {
    if (phoneNumber.isEmpty) {
      return 'Phone number is required';
    }

    final rule = _validationRules[countryCode];
    if (rule != null) {
      return rule.validate(phoneNumber);
    }

    if (phoneNumber.length < 7 ||
        phoneNumber.length > 15 ||
        !RegExp(r'^[0-9]{7,15}$').hasMatch(phoneNumber)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static PhoneNumberInfo parsePhoneNumber(String fullNumber) {
    if (fullNumber.isEmpty) {
      return PhoneNumberInfo(countryCode: '+91', phoneNumber: '');
    }

    final RegExp countryCodeRegex = RegExp(r'^\+\d{1,4}');
    final match = countryCodeRegex.firstMatch(fullNumber);

    if (match != null) {
      return PhoneNumberInfo(
        countryCode: match.group(0)!,
        phoneNumber: fullNumber.substring(match.end).trim(),
      );
    }

    return PhoneNumberInfo(countryCode: '+91', phoneNumber: fullNumber.trim());
  }
}

class PhoneValidationRule {
  final int? length;
  final int? minLength;
  final int? maxLength;
  final String pattern;
  final String errorMessage;

  const PhoneValidationRule({
    this.length,
    this.minLength,
    this.maxLength,
    required this.pattern,
    required this.errorMessage,
  });

  String? validate(String phoneNumber) {
    if (length != null && phoneNumber.length != length) {
      return errorMessage;
    }

    if (minLength != null && phoneNumber.length < minLength!) {
      return errorMessage;
    }

    if (maxLength != null && phoneNumber.length > maxLength!) {
      return errorMessage;
    }

    if (!RegExp(pattern).hasMatch(phoneNumber)) {
      return errorMessage;
    }

    return null;
  }
}

class PhoneNumberInfo {
  final String countryCode;
  final String phoneNumber;

  const PhoneNumberInfo({
    required this.countryCode,
    required this.phoneNumber,
  });

  String get fullNumber => '$countryCode $phoneNumber';
  String get formattedNumber =>
      '$countryCode ${_formatPhoneNumber(phoneNumber)}';

  String _formatPhoneNumber(String phoneNumber) {
    final digits = phoneNumber.replaceAll(' ', '');
    if (digits.length <= 5) {
      return digits;
    } else {
      return '${digits.substring(0, 5)} ${digits.substring(5)}';
    }
  }
}

class ReusablePhoneTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(PhoneNumberInfo)? onPhoneNumberChanged;
  final String? errorText;
  final double height;
  final String labelText;
  final String hintText;
  final List<String> favoriteCountries;
  final String defaultCountryCode;
  final bool enabled;
  final InputDecoration? decoration;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final bool autoValidate;

  const ReusablePhoneTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onPhoneNumberChanged,
    this.errorText,
    this.height = 56.0,
    this.labelText = 'Mobile Number',
    this.hintText = '00000 00000',
    this.favoriteCountries = const ['+91', '+1', '+44'],
    this.defaultCountryCode = '+91',
    this.enabled = true,
    this.decoration,
    this.labelStyle,
    this.textStyle,
    this.autoValidate = false,
  });

  @override
  State<ReusablePhoneTextField> createState() => _ReusablePhoneTextFieldState();
}

class _ReusablePhoneTextFieldState extends State<ReusablePhoneTextField> {
  late TextEditingController _controller;
  late String _countryCode;
  String _phoneNumber = '';
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _countryCode = widget.defaultCountryCode;

    if (_controller.text.isNotEmpty) {
      _parseExistingNumber(_controller.text);
    }

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    final expectedText = '$_countryCode $_phoneNumber';
    if (_controller.text != expectedText) {
      _parseExistingNumber(_controller.text);
    }
  }

  void _parseExistingNumber(String fullNumber) {
    final phoneInfo = PhoneValidationService.parsePhoneNumber(fullNumber);
    setState(() {
      _countryCode = phoneInfo.countryCode;
      _phoneNumber = phoneInfo.phoneNumber;
    });
  }

  void _updateFullNumber() {
    final phoneInfo = PhoneNumberInfo(
      countryCode: _countryCode,
      phoneNumber: _phoneNumber,
    );

    final fullNumber = phoneInfo.formattedNumber;

    if (_controller.text != fullNumber) {
      _controller.value = TextEditingValue(
        text: fullNumber,
        selection: TextSelection.collapsed(offset: fullNumber.length),
      );
    }

    widget.onChanged?.call(fullNumber);
    widget.onPhoneNumberChanged?.call(phoneInfo);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return PhoneInputField(
      height: widget.height,
      labelText: widget.labelText,
      errorText: widget.errorText,
      isFocused: _isFocused,
      enabled: widget.enabled,
      countryCode: _countryCode,
      onCountryChanged: (code) {
        setState(() => _countryCode = code);
        _updateFullNumber();
      },
      favoriteCountries: widget.favoriteCountries,
      child: TextFormField(
        controller: TextEditingController(text: _phoneNumber),
        focusNode: _focusNode,
        enabled: widget.enabled,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(15),
          PhoneNumberFormatter(),
        ],
        onChanged: (value) {
          final digitsOnly = value.replaceAll(' ', '');
          setState(() => _phoneNumber = digitsOnly);
          _updateFullNumber();

          if (widget.autoValidate) {
            final error = PhoneValidationService.validatePhoneNumber(
              digitsOnly,
              _countryCode,
            );
          }
        },
        validator: widget.validator,
        style: widget.textStyle ??
            theme.textTheme.bodyLarge?.copyWith(
              color: appColors.onSurface,
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
          hintText: widget.hintText,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: appColors.onSurfaceVariant.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}

class PhoneInputField extends StatelessWidget {
  final double height;
  final String labelText;
  final String? errorText;
  final bool isFocused;
  final bool enabled;
  final String countryCode;
  final void Function(String) onCountryChanged;
  final List<String> favoriteCountries;
  final Widget child;
  final TextStyle? labelStyle;

  const PhoneInputField({
    Key? key,
    required this.height,
    required this.labelText,
    this.errorText,
    required this.isFocused,
    this.enabled = true,
    required this.countryCode,
    required this.onCountryChanged,
    this.favoriteCountries = const ['+91', '+1', '+44'],
    required this.child,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    Color borderColor;
    if (errorText != null) {
      borderColor = Colors.red;
    } else if (isFocused) {
      borderColor = appColors.primary;
    } else {
      borderColor = appColors.outline;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            labelText,
            style: labelStyle ??
                AppTypography.getLoginSubtitle(context).copyWith(
                  color: errorText != null
                      ? Colors.red
                      : (isFocused
                          ? appColors.primary
                          : appColors.onSurfaceVariant),
                ),
          ),
        ),

        // Input Field
        Container(
          height: height,
          decoration: BoxDecoration(
            color: enabled
                ? appColors.surface
                : appColors.surface.withOpacity(0.6),
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              // Country Code Section
              CountryCodePicker(
                height: height,
                countryCode: countryCode,
                enabled: enabled,
                favoriteCountries: favoriteCountries,
                onChanged: onCountryChanged,
              ),

              // Divider
              Container(
                height: height * 0.5,
                width: 1.0,
                color: appColors.outline,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),

              // Phone Number Input
              Expanded(child: child),
            ],
          ),
        ),

        // Error Text
        SizedBox(
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
        ),
      ],
    );
  }
}

class CountryCodePicker extends StatelessWidget {
  final double height;
  final String countryCode;
  final bool enabled;
  final List<String> favoriteCountries;
  final void Function(String) onChanged;

  const CountryCodePicker({
    super.key,
    required this.height,
    required this.countryCode,
    this.enabled = true,
    this.favoriteCountries = const ['+91', '+1', '+44'],
    required this.onChanged,
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
              style: AppTypography.getCountryCodeText(context).copyWith(
                color: enabled ? null : appColors.onSurface.withOpacity(0.5),
              ),
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
      onSelect: (Country country) {
        onChanged('+${country.phoneCode}');
      },
      favorite: favoriteCountries,
      showPhoneCode: true,
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 5) {
        formatted += ' ';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

abstract class BaseAuthScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BaseAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: handleAuthStateChange,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: appColors.backgroundGradient,
                ),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: formKey,
                          child: buildBody(context, state),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading(state)) buildLoadingOverlay(context, state),
          ],
        );
      },
    );
  }

  Widget buildBody(BuildContext context, AuthState state);
  void handleAuthStateChange(BuildContext context, AuthState state);
  bool isLoading(AuthState state);
  Widget buildLoadingOverlay(BuildContext context, AuthState state);

  Widget buildHeaderSection(
    BuildContext context, {
    required String imageAsset,
    double imageHeight = 160.0,
    double imageWidth = 160.0,
    double topPadding = 63.0,
    double bottomPadding = 32.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Center(
        child: AppHeaderImage(
          height: imageHeight,
          width: imageWidth,
          imageAsset: imageAsset,
        ),
      ),
    );
  }

  Widget buildTitleSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    double spacing = 11.0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.getLoginTitle(context)),
        SizedBox(height: spacing),
        Text(subtitle, style: AppTypography.getLoginSubtitle(context)),
      ],
    );
  }

  Widget buildActionButton(
    BuildContext context, {
    required String text,
    required VoidCallback onPressed,
    double height = 58.0,
    double bottomPadding = 20.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text, style: AppTypography.getButtonText(context)),
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, String route, {Object? extra}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (extra != null) {
        context.go(route, extra: extra);
      } else {
        context.go(route);
      }
    });
  }

  void showErrorDialog(
    BuildContext context,
    String error, {
    String title = 'Error',
    String buttonLabel = 'Try Again',
    VoidCallback? onPressed,
  }) {
    AppErrorDisplay.showDialog(
      context,
      error,
      title: title,
      buttonLabel: buttonLabel,
      onPressed: onPressed,
    );
  }
}

class LoginScreen extends BaseAuthScreen {
  final TextEditingController _phoneNumberController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget buildBody(BuildContext context, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeaderSection(
          context,
          imageAsset: AppAsset.authHeader,
        ),
        buildTitleSection(
          context,
          title: "Login",
          subtitle: "Enter your mobile number",
        ),
        const SizedBox(height: 40.0),
        _buildPhoneInputSection(context, state),
        const SizedBox(height: 16.0),
        const Spacer(),
        buildActionButton(
          context,
          text: "Verify",
          onPressed: () => _onLoginPressed(context),
        ),
      ],
    );
  }

  Widget _buildPhoneInputSection(BuildContext context, AuthState state) {
    String? errorText;
    if (state is ValidationError) {
      errorText = state.error;
    }

    return ReusablePhoneTextField(
      controller: _phoneNumberController,
      labelText: "Mobile Number",
      height: 56.0,
      errorText: errorText,
      autoValidate: true,
      onPhoneNumberChanged: (phoneInfo) {
        if (state is ValidationError) {
          context.read<AuthBloc>().add(ClearValidationError());
        }
      },
    );
  }

  void _onLoginPressed(BuildContext context) {
    context.read<AuthBloc>().add(ClearValidationError());

    final fullPhoneNumber = _phoneNumberController.text;
    final phoneInfo = PhoneValidationService.parsePhoneNumber(fullPhoneNumber);

    final validationError = PhoneValidationService.validatePhoneNumber(
      phoneInfo.phoneNumber.replaceAll(' ', ''),
      phoneInfo.countryCode,
    );

    if (validationError != null) {
      context.read<AuthBloc>().add(ValidationErrorTriggered(validationError));
      return;
    }

    context.read<AuthBloc>().add(
          LoginRequested(fullPhoneNumber.replaceAll(' ', '')),
        );
  }

  @override
  void handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case SignInSuccess():
        navigateTo(context, AppRoutes.otp, extra: _phoneNumberController.text);
        break;
      case SignInFailure():
        showErrorDialog(
          context,
          state.error,
          title: 'Login Error',
          onPressed: () => _onLoginPressed(context),
        );
        break;
      case ValidationError():
        // Handled inline by the UI
        break;
      default:
        break;
    }
  }

  @override
  bool isLoading(AuthState state) => state is SignInLoading;

  @override
  Widget buildLoadingOverlay(BuildContext context, AuthState state) {
    return ProgressDialog(
      title: "Generating OTP...",
      isProgressed: true,
    );
  }
}
