// Flutter imports:
// ignore_for_file: deprecated_member_use

import 'package:customer_app/features/auth/presentation/screens/login_screen.dart';
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


class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final GlobalKey<FormState> _setPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController = TextEditingController();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isReEnterPasswordVisible = ValueNotifier<bool>(false);

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
                          key: _setPasswordFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Image Section - Centered
                              _buildHeaderSection(context),

                              // Title Section - Left aligned
                              _buildTitleSection(context),

                              const SizedBox(height: 40.0),

                              // Password Input Section
                              _buildPasswordInputSection(context, state),

                              // Spacer to push content to bottom
                              const Spacer(),

                              // Bottom Section - Register Button
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
            if (state is SetPasswordLoading)
              ProgressDialog(
                title: "Setting up your account...",
                isProgressed: true,
              ),
          ],
        );
      },
    );
  }

  /// Builds the header section with shopping cart image
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
          imageAsset: AppAsset.authHeader, // Shopping cart with boxes image
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
          "Set Password",
          style: AppTypography.getLoginTitle(context),
        ),
        const SizedBox(height: 11.0),
        Text(
          "Set password to login",
          style: AppTypography.getLoginSubtitle(context),
        ),
      ],
    );
  }

  /// Builds the password input section
  Widget _buildPasswordInputSection(BuildContext context, AuthState state) {
    // Extract error text from ValidationError state
    String? passwordErrorText;
    String? reEnterPasswordErrorText;
    
    if (state is ValidationError) {
      if (state.field == 'password') {
        passwordErrorText = state.error;
      } else if (state.field == 'reEnterPassword') {
        reEnterPasswordErrorText = state.error;
      }
    }

    return Column(
      children: [
        // Password Field
        ValueListenableBuilder<bool>(
          valueListenable: _isPasswordVisible,
          builder: (context, isPasswordVisible, child) {
            return PasswordTextField(
              controller: _passwordController,
              labelText: "Password",
              height: 56.0,
              errorText: passwordErrorText,
             
              onChanged: (value) {
                // Clear password validation error when user starts typing
                if (state is ValidationError && state.field == 'password') {
                  context.read<AuthBloc>().add(ClearValidationError());
                }
              },
            );
          },
        ),
        
        const SizedBox(height: 20.0),
        
        // Re-Enter Password Field
        ValueListenableBuilder<bool>(
          valueListenable: _isReEnterPasswordVisible,
          builder: (context, isReEnterPasswordVisible, child) {
            return PasswordTextField(
              controller: _reEnterPasswordController,
              labelText: "Re-Enter Password",
              height: 56.0,
              // isPasswordVisible: isReEnterPasswordVisible,
              errorText: reEnterPasswordErrorText,
              // onVisibilityToggle: () {
              //   _isReEnterPasswordVisible.value = !_isReEnterPasswordVisible.value;
              // },
              onChanged: (value) {
                // Clear re-enter password validation error when user starts typing
                if (state is ValidationError && state.field == 'reEnterPassword') {
                  context.read<AuthBloc>().add(ClearValidationError());
                }
              },
            );
          },
        ),
      ],
    );
  }

  /// Builds the bottom section with register button
  Widget _buildBottomSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58.0,
      child: ElevatedButton(
        onPressed: () => _onRegisterPressed(context),
        child: Text(
          "Register",
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

  /// Handles auth state changes
  void _handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case SetPasswordSuccess():
        // Show success toast
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showSuccessToast();
        });
        // Navigate to location selection screen instead of login
        _navigateTo(context, AppRoutes.locationSelection);
        break;

      case SetPasswordFailure():
        AppErrorDisplay.showDialog(
          context,
          state.error,
          title: 'Password Setup Error',
          buttonLabel: 'Try Again',
          onPressed: () => _onRegisterPressed(context),
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

  /// Shows success toast message
  void _showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Password set successfully!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green.withOpacity(0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Handles the register button press
  void _onRegisterPressed(BuildContext context) {
    // Clear any previous validation errors
    context.read<AuthBloc>().add(ClearValidationError());

    final password = _passwordController.text;
    final reEnterPassword = _reEnterPasswordController.text;

    // Validate password
    String? passwordValidationError = _validatePassword(password);
    if (passwordValidationError != null) {
      context.read<AuthBloc>().add(
          ValidationErrorTriggered(passwordValidationError, field: 'password'));
      return;
    }

    // Validate re-enter password
    String? reEnterPasswordValidationError = _validateReEnterPassword(password, reEnterPassword);
    if (reEnterPasswordValidationError != null) {
      context.read<AuthBloc>().add(
          ValidationErrorTriggered(reEnterPasswordValidationError, field: 'reEnterPassword'));
      return;
    }

    // Proceed with password setup
    context.read<AuthBloc>().add(SetPasswordRequested(password));
  }

  /// Validates password
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }

    return null; // No error
  }

  /// Validates re-enter password
  String? _validateReEnterPassword(String password, String reEnterPassword) {
    if (reEnterPassword.isEmpty) {
      return 'Please re-enter your password';
    }

    if (password != reEnterPassword) {
      return 'Passwords do not match';
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

  @override
  void dispose() {
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    _isPasswordVisible.dispose();
    _isReEnterPasswordVisible.dispose();
    super.dispose();
  }
}