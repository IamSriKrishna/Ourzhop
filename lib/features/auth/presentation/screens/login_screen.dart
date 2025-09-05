// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_picker/country_picker.dart';

// Project imports:
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/validators/validators.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_header_image.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_state.dart';

// Unified Phone TextField Widget
class UnifiedPhoneTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;
  final double height;
  final String labelText;

  const UnifiedPhoneTextField({
    Key? key,
    this.controller,
    this.validator,
    this.onChanged,
    this.errorText,
    this.height = 56.0,
    this.labelText = 'Mobile Number',
  }) : super(key: key);

  @override
  State<UnifiedPhoneTextField> createState() => _UnifiedPhoneTextFieldState();
}

class _UnifiedPhoneTextFieldState extends State<UnifiedPhoneTextField> {
  late TextEditingController _controller;
  String _countryCode = '+91';
  String _phoneNumber = '';
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    // Initialize with existing text if any
    if (_controller.text.isNotEmpty) {
      _parseExistingNumber(_controller.text);
    }

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    // Listen to controller changes to update internal state
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (_controller.text != '$_countryCode $_phoneNumber') {
      _parseExistingNumber(_controller.text);
    }
  }

  void _parseExistingNumber(String fullNumber) {
    if (fullNumber.isEmpty) {
      setState(() {
        _phoneNumber = '';
      });
      return;
    }

    // Extract country code and phone number from full number
    final RegExp countryCodeRegex = RegExp(r'^\+\d{1,4}');
    final match = countryCodeRegex.firstMatch(fullNumber);

    if (match != null) {
      setState(() {
        _countryCode = match.group(0)!;
        _phoneNumber = fullNumber.substring(match.end).trim();
      });
    } else {
      setState(() {
        _phoneNumber = fullNumber.trim();
      });
    }
  }

  void _updateFullNumber() {
    final formattedPhone = _formatPhoneNumber(_phoneNumber);
    final fullNumber = '$_countryCode $formattedPhone';

    // Prevent infinite loop by checking if text is different
    if (_controller.text != fullNumber) {
      _controller.value = TextEditingValue(
        text: fullNumber,
        selection: TextSelection.collapsed(
          offset: fullNumber.length,
        ),
      );
    }

    if (widget.onChanged != null) {
      widget.onChanged!(fullNumber);
    }
  }

  String _formatPhoneNumber(String phoneNumber) {
    final digits = phoneNumber.replaceAll(' ', '');
    if (digits.length <= 5) {
      return digits;
    } else {
      return '${digits.substring(0, 5)} ${digits.substring(5)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Determine colors based on state
    Color borderColor;
    if (widget.errorText != null) {
      borderColor = Colors.red;
    } else if (_isFocused) {
      borderColor = appColors.primary;
    } else {
      borderColor = appColors.outline;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above the field
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            widget.labelText,
            style: AppTypography.getLoginSubtitle(context).copyWith(
              color: widget.errorText != null
                  ? Colors.red
                  : (_isFocused
                      ? appColors.primary
                      : appColors.onSurfaceVariant),
            ),
          ),
        ),

        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: appColors.surface,
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              // Country Code Picker Section
              InkWell(
                onTap: _showCountryPicker,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                child: Container(
                  height: widget.height,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _countryCode,
                        style: AppTypography.getCountryCodeText(context),
                      ),
                      const SizedBox(width: 4.0),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: appColors.primary,
                        size: 16.0,
                      ),
                    ],
                  ),
                ),
              ),

              // Divider
              Container(
                height: widget.height * 0.5,
                width: 1.0,
                color: appColors.outline,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),

              // Phone Number Input Section
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                    _PhoneNumberFormatter(),
                  ],
                  onChanged: (value) {
                    final digitsOnly = value.replaceAll(' ', '');
                    setState(() {
                      _phoneNumber = digitsOnly;
                    });
                    _updateFullNumber();
                  },
                  validator: widget.validator,
                  style: theme.textTheme.bodyLarge?.copyWith(
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
                    hintText: '00000 00000',
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: appColors.onSurfaceVariant.withOpacity(0.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error text with reserved space
        SizedBox(
          height: 30.0,
          child: widget.errorText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: Text(
                    widget.errorText!,
                    style: AppTypography.getErrorText(context),
                  ),
                )
              : null,
        ),
      ],
    );
  }

  void _showCountryPicker() {
    // Show the country picker directly without dialog wrapper
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
        setState(() {
          _countryCode = '+${country.phoneCode}';
        });
        _updateFullNumber();
      },
      favorite: ['+91', '+1', '+44'],
      showPhoneCode: true,
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

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Format as groups of digits with spaces (5 digits, space, 5 digits)
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

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: _handleAuthStateChange,
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
                          key: _loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Image Section - Centered
                              _buildHeaderSection(context),

                              // Title Section - Left aligned
                              _buildTitleSection(context),

                              const SizedBox(height: 40.0),

                              // Mobile Input Section
                              _buildMobileInputSection(context, state),

                              const SizedBox(height: 16.0),

                              const Spacer(),

                              // Bottom Section - Login Button
                              _buildBottomSection(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Loading overlay
            if (state is SignInLoading)
              ProgressDialog(
                title: "Generating OTP...",
                isProgressed: true,
              ),
          ],
        );
      },
    );
  }

  /// Builds the header section with image
  Widget _buildHeaderSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 63.0, // Design position: top: 103 - SafeArea = 63
        bottom: 32.0, // Spacing to title section
      ),
      child: Center(
        child: AppHeaderImage(
          height: 160.0, // Exact size from design specification
          width: 160.0,
          imageAsset: AppAsset.authHeader,
        ),
      ),
    );
  }

  /// Builds the title section
  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Login",
          style: AppTypography.getLoginTitle(context),
        ),
        const SizedBox(height: 11.0), // Design spacing between elements
        Text(
          "Enter your mobile number",
          style: AppTypography.getLoginSubtitle(context),
        ),
      ],
    );
  }

  /// Builds the mobile input section with enhanced phone text field
  Widget _buildMobileInputSection(BuildContext context, AuthState state) {
    // Extract error text from ValidationError state
    String? errorText;
    if (state is ValidationError) {
      errorText = state.error;
    }

    return UnifiedPhoneTextField(
      controller: _phoneNumberController,
      labelText: "Mobile Number",
      height: 56.0,
      errorText: errorText,
      onChanged: (value) {
        // Clear validation error when user starts typing
        if (state is ValidationError) {
          context.read<AuthBloc>().add(ClearValidationError());
        }
      },
    );
  }

  /// Builds the bottom section with verify button
  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 58.0, // Design height: 58
        child: ElevatedButton(
          onPressed: () => _onLoginPressed(context),
          child: Text(
            "Verify",
            style: AppTypography.getButtonText(context),
          ),
        ),
      ),
    );
  }

  /// Handles auth state changes
  void _handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case SignInSuccess():
        _navigateTo(context, AppRoutes.otp, extra: _phoneNumberController.text);
        break;

      case SignInFailure():
        AppErrorDisplay.showDialog(
          context,
          state.error,
          title: 'Login Error',
          buttonLabel: 'Try Again',
          onPressed: () => _onLoginPressed(context),
        );
        break;

      case ValidationError():
        // ValidationError is handled inline by the UI, no dialog needed
        // The error text is shown directly below the text field
        break;

      default:
        break;
    }
  }

  /// Handles the login button press
  void _onLoginPressed(BuildContext context) {
    // Clear any previous validation errors
    context.read<AuthBloc>().add(ClearValidationError());

    final fullPhoneNumber = _phoneNumberController.text;

    // Validate phone number
    if (fullPhoneNumber.isEmpty) {
      context
          .read<AuthBloc>()
          .add(ValidationErrorTriggered('Phone number is required'));
      return;
    }

    // Parse the full number to get country code and phone number
    final RegExp countryCodeRegex = RegExp(r'^\+\d{1,4}');
    final match = countryCodeRegex.firstMatch(fullPhoneNumber);

    String countryCode = '+91';
    String phoneNumber = fullPhoneNumber;

    if (match != null) {
      countryCode = match.group(0)!;
      phoneNumber =
          fullPhoneNumber.substring(match.end).trim().replaceAll(' ', '');
    }

    // Validate phone number based on country code
    String? phoneValidationError =
        _validatePhoneNumber(phoneNumber, countryCode);
    if (phoneValidationError != null) {
      context
          .read<AuthBloc>()
          .add(ValidationErrorTriggered(phoneValidationError));
      return;
    }

    // Dispatch the login request with the formatted phone number
    context
        .read<AuthBloc>()
        .add(LoginRequested(fullPhoneNumber.replaceAll(' ', '')));
  }

  /// Validates phone number based on country code
  String? _validatePhoneNumber(String phoneNumber, String countryCode) {
    if (phoneNumber.isEmpty) {
      return 'Phone number is required';
    }

    // Basic validation - you can enhance this based on country-specific rules
    switch (countryCode) {
      case '+91': // India
        if (phoneNumber.length != 10 ||
            !RegExp(r'^[6-9][0-9]{9}$').hasMatch(phoneNumber)) {
          return 'Please enter a valid 10-digit mobile number';
        }
        break;
      case '+1': // US/Canada
        if (phoneNumber.length != 10 ||
            !RegExp(r'^[2-9][0-9]{9}$').hasMatch(phoneNumber)) {
          return 'Please enter a valid 10-digit phone number';
        }
        break;
      case '+44': // UK
        if (phoneNumber.length < 10 ||
            phoneNumber.length > 11 ||
            !RegExp(r'^[1-9][0-9]{9,10}$').hasMatch(phoneNumber)) {
          return 'Please enter a valid UK phone number';
        }
        break;
      default: // Generic validation for other countries
        if (phoneNumber.length < 7 ||
            phoneNumber.length > 15 ||
            !RegExp(r'^[0-9]{7,15}$').hasMatch(phoneNumber)) {
          return 'Please enter a valid phone number';
        }
        break;
    }

    return null; // No error
  }

  /// Navigates to specified route
  void _navigateTo(BuildContext context, String route, {Object? extra}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (extra != null) {
        context.go(route, extra: extra);
      } else {
        context.go(route);
      }
    });
  }
}
