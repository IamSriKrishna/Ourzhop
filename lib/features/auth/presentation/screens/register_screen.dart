// Flutter imports:
// ignore_for_file: deprecated_member_use

import 'package:customer_app/features/auth/presentation/screens/login_screen.dart';
import 'package:customer_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Project imports:
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

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  RegisterScreen({super.key});

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
                          key: _registerFormKey,
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

                              // Spacer to push content to bottom
                              const Spacer(),

                              // Bottom Section - Continue Button
                              _buildBottomSection(context),

                              const SizedBox(height: 16.0),

                              // Login Link
                              _buildLoginLink(context),
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
            if (state is SignUpLoading)
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
          imageAsset: AppAsset.authHeader, // You can use a different image for register if needed
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
          "Register",
          style: AppTypography.getLoginTitle(context),
        ),
        const SizedBox(height: 11.0),
        Text(
          "Enter your mobile number",
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

  /// Builds the bottom section with continue button
  Widget _buildBottomSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58.0,
      child: ElevatedButton(
        onPressed: () => _onContinuePressed(context),
        child: Text(
          "Continue",
          style: AppTypography.getButtonText(context),
        ),
      ),
    );
  }

  /// Builds the login link at the bottom
  Widget _buildLoginLink(BuildContext context) {
    final appColors = context.appColors;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: AppTypography.getLoginSubtitle(context),
          ),
          GestureDetector(
            onTap: () {
              _navigateTo(context, AppRoutes.login);
            },
            child: Text(
              "Login",
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
        // Add a small delay to ensure the widget is built before showing toast
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showOtpToast(state.generatedOtp);
        });
        // Navigate to OTP screen with source indicator
        _navigateToOtp(context, state.mobileNumber, sourceScreen: 'register');
        break;

      case SignUpFailure():
        AppErrorDisplay.showDialog(
          context,
          state.error,
          title: 'Registration Error',
          buttonLabel: 'Try Again',
          onPressed: () => _onContinuePressed(context),
        );
        break;

      case ValidationError():
        // ValidationError is handled inline by the UI, no dialog needed
        break;

      default:
        break;
    }
  }
  void _navigateToOtp(BuildContext context, String mobileNumber, {String? sourceScreen}) {
    try {
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

  /// Handles the continue button press
  void _onContinuePressed(BuildContext context) {
    // Clear any previous validation errors
    context.read<AuthBloc>().add(ClearValidationError());

    final fullPhoneNumber = _phoneNumberController.text;

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

    // Proceed with registration (bypass to OTP)
    context.read<AuthBloc>().add(RegisterRequested(
        fullPhoneNumber.replaceAll(' ', '')));
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