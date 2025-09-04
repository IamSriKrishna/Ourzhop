// Flutter imports:
// ignore_for_file: deprecated_member_use

import 'package:customer_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
import 'package:customer_app/common/dialog/progress_dialog.dart';
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

// Password TextField Widget
class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? errorText;
  final double height;
  final String labelText;
  final String hintText;

  const PasswordTextField({
    Key? key,
    this.controller,
    this.validator,
    this.onChanged,
    this.errorText,
    this.height = 56.0,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
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
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: _obscureText,
            onChanged: widget.onChanged,
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
                horizontal: 16.0,
                vertical: 16.0,
              ),
              hintText: widget.hintText,
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                color: appColors.onSurfaceVariant.withOpacity(0.6),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: appColors.onSurfaceVariant,
                  size: 20.0,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
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

  @override
  void dispose() {
    _focusNode.dispose();
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

// Complete LoginScreen with Both Phone and Password Fields - EXACT UI MATCH
class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

                              // Password Input Section
                              _buildPasswordInputSection(context, state),

                              // Forget Password Link
                              _buildForgetPasswordLink(context),

                              // Spacer to push content to bottom
                              const Spacer(),

                              // Bottom Section - Login Button
                              _buildBottomSection(context),

                              const SizedBox(height: 16.0),

                              // Register Link
                              _buildRegisterLink(context),
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
        top: 40.0,
        bottom: 20.0,
      ),
      child: Center(
        child: AppHeaderImage(
          height: 160.0,
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
        const SizedBox(height: 11.0),
        Text(
          "Enter mobile number & Password",
          style: AppTypography.getLoginSubtitle(context),
        ),
      ],
    );
  }

  /// Builds the mobile input section
  Widget _buildMobileInputSection(BuildContext context, AuthState state) {
    // Extract error text from ValidationError state for phone
    String? phoneErrorText;
    if (state is ValidationError && state.field == 'phone') {
      phoneErrorText = state.error;
    }

    return UnifiedPhoneTextField(
      controller: _phoneNumberController,
      labelText: "Mobile Number",
      height: 56.0,
      errorText: phoneErrorText,
      onChanged: (value) {
        // Clear phone validation error when user starts typing
        if (state is ValidationError && state.field == 'phone') {
          context.read<AuthBloc>().add(ClearValidationError());
        }
      },
    );
  }

  /// Builds the password input section
  Widget _buildPasswordInputSection(BuildContext context, AuthState state) {
    // Extract error text from ValidationError state for password
    String? passwordErrorText;
    if (state is ValidationError && state.field == 'password') {
      passwordErrorText = state.error;
    }

    return PasswordTextField(
      controller: _passwordController,
      labelText: "Password",
      height: 56.0,
      hintText: "Enter your password",
      errorText: passwordErrorText,
      onChanged: (value) {
        // Clear password validation error when user starts typing
        if (state is ValidationError && state.field == 'password') {
          context.read<AuthBloc>().add(ClearValidationError());
        }
      },
    );
  }

  /// Builds the forget password link
  Widget _buildForgetPasswordLink(BuildContext context) {
    final appColors = context.appColors;

    return Align(
      alignment: Alignment(0, 0),
      child: TextButton(
        onPressed: () {
          // Navigate to forget password screen
          // context.go(AppRoutes.forgotPassword);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          "Forget Password?",
          style: AppTypography.getLoginSubtitle(context).copyWith(
            color: appColors.primary,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  /// Builds the bottom section with login button
  Widget _buildBottomSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58.0,
      child: ElevatedButton(
        onPressed: () => _onLoginPressed(context),
        child: Text(
          "Login",
          style: AppTypography.getButtonText(context),
        ),
      ),
    );
  }

  /// Builds the register link at the bottom
  Widget _buildRegisterLink(BuildContext context) {
    final appColors = context.appColors;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Doesn't have an account?",
            style: AppTypography.getLoginSubtitle(context),
          ),
          GestureDetector(
            onTap: () {
              print('Register link tapped'); // Debug print
              print('Navigating to: ${AppRoutes.register}'); // Debug print
              _navigateTo(context, AppRoutes.register);
            },
            child: Text(
              "Register Now",
              style: AppTypography.getLoginSubtitle(context).copyWith(
                color: appColors.primary,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case NavigateToOtpWithToast():
        // Show toast with generated OTP
        _showOtpToast(state.generatedOtp);
        // Navigate to OTP screen with source indicator
        _navigateToOtp(context, state.mobileNumber, sourceScreen: 'login');
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
        break;

      default:
        break;
    }
  }

   /// Navigate to OTP screen with source tracking
  void _navigateToOtp(BuildContext context, String mobileNumber, {String? sourceScreen}) {
    try {
      // Create the OTP screen with source parameter
      final otpScreen = OtpScreen(
        mobileNumber: mobileNumber,
        sourceScreen: sourceScreen,
      );
      
      // Navigate using go_router with the widget
      context.go(AppRoutes.otp, extra: {
        'mobileNumber': mobileNumber,
        'sourceScreen': sourceScreen,
      });
    } catch (e) {
      print('Navigation error: $e');
      // Fallback navigation
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            mobileNumber: mobileNumber,
            sourceScreen: sourceScreen,
          ),
        ),
      );
    }
  }

  /// Shows toast message with generated OTP
  void _showOtpToast(String otp) {
    Fluttertoast.showToast(
      msg: "OTP: $otp",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Handles the login button press
  void _onLoginPressed(BuildContext context) {
    // Clear any previous validation errors
    context.read<AuthBloc>().add(ClearValidationError());

    final fullPhoneNumber = _phoneNumberController.text;
    final password = _passwordController.text;

    // Validate phone number
    if (fullPhoneNumber.isEmpty) {
      context.read<AuthBloc>().add(
          ValidationErrorTriggered('Phone number is required', field: 'phone'));
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
          .add(ValidationErrorTriggered(phoneValidationError, field: 'phone'));
      return;
    }

    // Validate password
    if (password.isEmpty) {
      context.read<AuthBloc>().add(
          ValidationErrorTriggered('Password is required', field: 'password'));
      return;
    }

    if (password.length < 6) {
      context.read<AuthBloc>().add(ValidationErrorTriggered(
          'Password must be at least 6 characters',
          field: 'password'));
      return;
    }

    // Proceed with login (bypass to OTP)
    context.read<AuthBloc>().add(LoginRequested(
        fullPhoneNumber.replaceAll(' ', ''),
        password: password));
  }
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
      case '+103': // Custom country code
        if (phoneNumber.length < 8 ||
            phoneNumber.length > 15 ||
            !RegExp(r'^[0-9]{8,15}$').hasMatch(phoneNumber)) {
          return 'Please enter a valid phone number';
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

  void _navigateTo(BuildContext context, String route, {Object? extra}) {
    // Use immediate navigation instead of addPostFrameCallback for auth routes
    try {
      if (extra != null) {
        context.go(route, extra: extra);
      } else {
        context.go(route);
      }
    } catch (e) {
      // Fallback to push for auth routes if go fails
      print('Navigation error with go(), trying push: $e');
      try {
        if (extra != null) {
          context.push(route, extra: extra);
        } else {
          context.push(route);
        }
      } catch (pushError) {
        print('Navigation error with push(): $pushError');
        // Ultimate fallback
        Navigator.of(context).pushNamed(route);
      }
    }
  }
}