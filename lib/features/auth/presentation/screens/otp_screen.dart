// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/validators/validators.dart';
import 'package:customer_app/common/widget/app_bottom_text_prompt.dart';
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

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String? sourceScreen;

  const OtpScreen({
    super.key,
    required this.mobileNumber,
    this.sourceScreen,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _showTopToast = false;
  String? _currentOtp;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Show OTP toast when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOtpTopToast();
    });
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  /// Shows top notification toast with the generated OTP
  void _showOtpTopToast() {
    final authBloc = context.read<AuthBloc>();
    final generatedOtp = authBloc.generatedOtp;

    if (generatedOtp != null) {
      setState(() {
        _currentOtp = generatedOtp;
        _showTopToast = true;
      });

      _animationController.forward();

      // Auto hide after 6 seconds
      Future.delayed(const Duration(seconds: 6), () {
        _hideTopToast();
      });
    }
  }

  void _hideTopToast() {
    _animationController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _showTopToast = false;
          _currentOtp = null;
        });
      }
    });
  }

  Widget _buildTopToast() {
    if (!_showTopToast || _currentOtp == null) return const SizedBox.shrink();

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade600,
                  Colors.green.shade700,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.security,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Your OTP Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentOtp!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Copy OTP to clipboard
                    Clipboard.setData(ClipboardData(text: _currentOtp!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('OTP copied to clipboard'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green.shade600,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _hideTopToast,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
            // Top Toast Notification
            _buildTopToast(),
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
      phoneNumber: widget.mobileNumber,
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
          // Login prompt
          AppBottomTextPrompt(
            promptText: "Already have an account?",
            actionText: "Login",
            onActionTapped: () => context.go(AppRoutes.login),
          ),
        ],
      ),
    );
  }
/// Handles auth state changes
  void _handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case OtpVerifySuccess():
        // Navigate based on source screen
        if (widget.sourceScreen == 'register') {
          // User came from registration - go to set password
          _navigateTo(context, AppRoutes.setPassword);
        } else if (widget.sourceScreen == 'login') {
          // User came from login - go to account setup
          _navigateTo(context, AppRoutes.accountSetup);
        } else {
          // Default fallback - check if user is new
          _navigateTo(context, AppRoutes.accountSetup);
        }
        break;

      case IsNewUser():
        // This case handles scenarios where we need to check user status
        if (widget.sourceScreen == 'register') {
          // New user from registration - go to set password
          _navigateTo(context, AppRoutes.setPassword);
        } else {
          // Existing user or login flow - go to account setup
          _navigateTo(context, AppRoutes.accountSetup);
        }
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
    final formattedMobile = "+91${widget.mobileNumber}";
    context.read<AuthBloc>().add(OtpVerifyRequested(formattedMobile, otpInput));
  }

  /// Handles the resend OTP button press
  void _onResendPressed(BuildContext context) {
    final formattedMobile = "+91${widget.mobileNumber}";
    context.read<AuthBloc>().add(LoginRequested(formattedMobile, password: ""));

    // Show new OTP toast after resend
    Future.delayed(const Duration(milliseconds: 800), () {
      _showOtpTopToast();
    });
  }

  /// Navigates to specified route
  void _navigateTo(BuildContext context, String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(route);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}
