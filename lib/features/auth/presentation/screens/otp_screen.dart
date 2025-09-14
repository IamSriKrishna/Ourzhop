// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/validators/validators.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_header_image.dart';
import 'package:customer_app/common/widget/app_otp_text_field.dart';
import 'package:customer_app/common/widget/app_phone_number_display.dart';
import 'package:customer_app/common/widget/app_resend_timer.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:logger/logger.dart';

class OtpScreen extends StatelessWidget {
  final String mobileNumber;
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  OtpScreen({super.key, required this.mobileNumber});

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
                          key: _otpFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Image Section - Centered
                              _buildHeaderSection(context),
                        
                              // Title Section - Left aligned
                              _buildTitleSection(context),
                        
                              const SizedBox(height: 20.0),
                        
                              // Phone Number Section - Left aligned
                              _buildPhoneNumberSection(context),
                        
                              const SizedBox(height: 30.0),
                        
                              // OTP Input Section - Centered
                              _buildOtpInputSection(context),
                        
                              const SizedBox(height: 20.0),
                        
                              // Resend Section - Centered
                              _buildResendSection(context),
                        
                              // Spacer to push button to bottom
                              const Spacer(),
                        
                              // Bottom Section - Button and Login Prompt
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
            if (state is OtpVerifyLoading)
              ProgressDialog(
                title: context.tr.verifyOtpProgressVerifying,
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
          "OTP",
          style: AppTypography.getOtpTitle(context),
        ),
        const SizedBox(height: 11.0),
        Text(
          "Enter the OTP sent to your number",
          style: AppTypography.getOtpSubtitle(context),
        ),
      ],
    );
  }

  /// Builds the phone number section
  Widget _buildPhoneNumberSection(BuildContext context) {
    return AppPhoneNumberDisplay(
      phoneNumber: mobileNumber,
      onEditTapped: () => context.go(AppRoutes.login),
    );
  }

  /// Builds the OTP input section
  Widget _buildOtpInputSection(BuildContext context) {
    return Center(
      child: AppOtpTextField(
        validator: Validators.validateOtp,
        controller: _otpController,
        spacing: 20.0,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        onCompleted: (value) {
          if (value.length == 4) {
            _onOtpPressed(context);
          }
        },
      ),
    );
  }

  /// Builds the resend section
  Widget _buildResendSection(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Center(
          child: AppResendTimer(
            initialTimeInSeconds: 30,
            resendText: "Resend",
            onResendTapped: () => _onResendPressed(context),
          ),
        );
      },
    );
  }

  /// Builds the bottom section with login prompt
  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Verify button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _onOtpPressed(context),
              child: Text(
                context.tr.verifyOtpButtonTitle,
                style: AppTypography.getButtonText(context),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          
        ],
      ),
    );
  }

  /// Handles auth state changes
  void _handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case OtpVerifySuccess():
        _navigateTo(context, AppRoutes.home);
        break;

      case IsNewUser():
        _navigateTo(context, AppRoutes.accountSetup);
        break;
      case NeedsLocationSelection():
        _navigateTo(context, AppRoutes.locationSelection);
        break;

      case OtpVerifyFailure():
        AppErrorDisplay.showDialog(
          context,
          state.error,
          title: 'OTP Verification Failed',
          buttonLabel: 'Try Again',
          onPressed: () => _onOtpPressed(context),
        );
        break;

      default:
        break;
    }
  }

  /// Handles the OTP button press
  void _onOtpPressed(BuildContext context) {
    if (!(_otpFormKey.currentState?.validate() ?? false)) return;
    final otpInput = _otpController.text.trim();
    final formattedMobile = mobileNumber.replaceAll(' ', '');
    Logger().i(formattedMobile);
    context.read<AuthBloc>().add(OtpVerifyRequested(formattedMobile, otpInput));
  }

  /// Handles the resend OTP button press
  void _onResendPressed(BuildContext context) {
    final formattedMobile = "+91$mobileNumber";
    context.read<AuthBloc>().add(LoginRequested(formattedMobile));
  }

  /// Navigates to specified route
  void _navigateTo(BuildContext context, String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(route);
    });
  }
}