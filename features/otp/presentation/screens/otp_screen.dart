// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:customer_app/common/validation/otp_input.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_header_image.dart';
import 'package:customer_app/common/widget/app_loading_overlay.dart';
import 'package:customer_app/common/widget/app_otp_text_field.dart';
import 'package:customer_app/common/widget/app_phone_number_display.dart';
import 'package:customer_app/common/widget/app_primary_action_button.dart';
import 'package:customer_app/common/widget/app_resend_timer.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/constants/otp_constant.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/core/l10n/app_localizations.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:customer_app/features/otp/presentation/bloc/otp_event.dart';
import 'package:customer_app/features/otp/presentation/bloc/otp_state.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({super.key, required this.mobileNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // Instance controllers with proper lifecycle management (following login pattern)
  late final TextEditingController _otpController;
  late final FocusNode _otpFocusNode;
  late final GlobalKey<FormState> _formKey;
  String _lastValidOtp = '';

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _otpFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // CRITICAL: Always dispose controllers to prevent memory leaks
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listenWhen: (previous, current) =>
          current is OtpVerifySuccess ||
          current is OtpVerifyFailure ||
          current is IsNewUser ||
          current is NeedsLocationSelection,
      buildWhen: (previous, current) =>
          (previous is OtpVerifyLoading) != (current is OtpVerifyLoading) ||
          (previous is OtpInitial &&
              current is OtpInitial &&
              (previous.shouldShowValidationError !=
                      current.shouldShowValidationError ||
                  previous.otpError != current.otpError)),
      listener: _handleOtpStateChange,
      builder: (context, state) {
        final shouldShowLoading = _shouldShowLoading(state);
        return _buildMainScaffold(context, shouldShowLoading);
      },
    );
  }

  Widget _buildMainScaffold(BuildContext context, bool shouldShowLoading) {
    final appColors = context.appColors;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Handle back button by navigating to login with phone number
        context.go(AppRoutes.login, extra: widget.mobileNumber);
      },
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              decoration: BoxDecoration(gradient: appColors.backgroundGradient),
              child: SafeArea(
                child: _buildScrollableContent(context),
              ),
            ),
          ),
          if (shouldShowLoading)
            AppLoadingOverlay(
              message: context.tr.verifyOtpProgressVerifying,
            ),
        ],
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: _buildMainContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
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

        // OTP Input Section - Centered with validation
        _buildOtpInputSection(context),

        const SizedBox(height: 20.0),

        // Resend Section - Centered
        _buildResendSection(context),

        // Spacer to push button to bottom
        const Spacer(),

        // Bottom Section - Button
        _buildBottomSection(context),
      ],
    );
  }

  /// Check if loading state should be shown
  bool _shouldShowLoading(OtpState state) {
    return state is OtpVerifyLoading;
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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.otpTitle,
          style: AppTypography.getOtpTitle(context),
        ),
        const SizedBox(height: 11.0),
        Text(
          l10n.otpSubtitle,
          style: AppTypography.getOtpSubtitle(context),
        ),
      ],
    );
  }

  /// Builds the phone number section
  Widget _buildPhoneNumberSection(BuildContext context) {
    return AppPhoneNumberDisplay(
      phoneNumber: widget.mobileNumber,
      // CRITICAL FIX: Use context.go() with phone number to fix GoRouter "nothing to pop" error
      // Pass the phone number back to login screen for pre-population
      onEditTapped: () =>
          context.go(AppRoutes.login, extra: widget.mobileNumber),
    );
  }

  /// Builds the OTP input section with validation
  Widget _buildOtpInputSection(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(
      buildWhen: (previous, current) {
        // Always rebuild when entering/leaving OtpInitial state
        if (previous is! OtpInitial && current is OtpInitial) return true;
        if (previous is OtpInitial && current is! OtpInitial) return true;

        // For OtpInitial to OtpInitial transitions, rebuild when:
        // 1. Validation error state changes
        // 2. OTP error type changes
        // 3. OTP value changes (critical for onCompleted callback)
        if (previous is OtpInitial && current is OtpInitial) {
          return previous.shouldShowValidationError !=
                  current.shouldShowValidationError ||
              previous.otpError != current.otpError ||
              previous.otpValue != current.otpValue;
        }

        // For non-OtpInitial states, don't rebuild unnecessarily
        return false;
      },
      builder: (context, state) {
        // Determine interaction state based on current state
        final isInteractive = state is OtpInitial;
        final shouldShowError = isInteractive &&
            state.shouldShowValidationError &&
            state.otpError != null;

        return Center(
          child: Column(
            children: [
              AppOtpTextField(
                key: const ValueKey('otp_input'),
                controller: _otpController,
                length: OtpConstants.defaultOtpLength,
                spacing: OtpConstants.defaultSpacing,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                      OtpConstants.defaultOtpLength),
                ],
                // Conditionally enable interaction based on state
                onChanged: isInteractive
                    ? (otp) => _handleOtpChange(context, otp)
                    : null,
              ),
              // Error display (only shown for interactive state with errors)
              if (shouldShowError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _getErrorText(context, state.otpError),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Handle OTP changes with instant feedback (following login pattern)
  void _handleOtpChange(BuildContext context, String otp) {
    // Update OTP in BLoC - this triggers validation and auto-hides errors
    context.read<OtpBloc>().add(OtpChanged(otp));

    // Auto-submit when OTP is complete
    if (otp.length == OtpConstants.defaultOtpLength) {
      // Small delay to ensure BLoC state is updated before validation
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleOtpPressed(context);
      });
    }
  }

  /// Builds the resend section
  Widget _buildResendSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Center(
          child: AppResendTimer(
            initialTimeInSeconds: 30,
            resendText: l10n.resendButtonTitle,
            onResendTapped: () => _onResendPressed(context),
          ),
        );
      },
    );
  }

  /// Builds the bottom section with action button (following login pattern)
  Widget _buildBottomSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<OtpBloc, OtpState>(
      buildWhen: (previous, current) =>
          (previous is OtpVerifyLoading) != (current is OtpVerifyLoading),
      builder: (context, state) {
        final isEnabled = state is! OtpVerifyLoading;
        return AppPrimaryActionButton(
          text: l10n.verifyOtpButtonTitle,
          onPressed: () => _handleOtpPressed(context),
          enabled: isEnabled,
        );
      },
    );
  }

  /// Handles OTP state changes
  void _handleOtpStateChange(BuildContext context, OtpState state) {
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
        AppErrorDisplay.showSnackBar(
          context,
          state.error,
          duration: const Duration(seconds: 4),
        );
        // Reset BLoC to initial state with current OTP value for retry
        final currentOtp = _otpController.text;
        context.read<OtpBloc>().add(OtpChanged(currentOtp));
        // Focus OTP field for user convenience
        _otpFocusNode.requestFocus();
        break;

      default:
        break;
    }
  }

  /// Handles the OTP button press (following login pattern)
  void _handleOtpPressed(BuildContext context) {
    final otpBloc = context.read<OtpBloc>();

    // Get current OTP value from controller (direct source of truth)
    final currentOtp = _otpController.text;

    // Ensure we're in OtpInitial state with current OTP value
    // This handles any edge cases where state might not be synchronized
    otpBloc.add(OtpChanged(currentOtp));

    // Use postframe callback to ensure state update completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = otpBloc.state;

      if (state is! OtpInitial) {
        // Should not happen, but handle gracefully
        return;
      }

      // Use FormZ validation result directly from BLoC state
      if (!state.isValid) {
        otpBloc.add(const OtpShowValidationError());
        _otpFocusNode.requestFocus();
        return;
      }

      // Valid OTP - hide errors and submit
      otpBloc.add(const OtpHideValidationError());
      _submitOtp(context, currentOtp);
    });
  }

  /// Submit OTP verification request
  void _submitOtp(BuildContext context, String otp) {
    _lastValidOtp = otp;
    final formattedMobile = widget.mobileNumber.replaceAll(' ', '');
    Logger().i(formattedMobile);
    context
        .read<OtpBloc>()
        .add(OtpVerifyRequested(formattedMobile, _lastValidOtp));
  }

  /// Get localized error message for OTP validation
  String _getErrorText(BuildContext context, OtpValidationError? error) {
    if (error == null) return '';

    switch (error) {
      case OtpValidationError.empty:
        return 'OTP is required';
      case OtpValidationError.incomplete:
        return 'Please enter complete 4-digit OTP';
      case OtpValidationError.invalid:
        return 'OTP must contain only numbers';
    }
  }

  /// Handles the resend OTP button press
  void _onResendPressed(BuildContext context) {
    context.read<OtpBloc>().add(OtpResendRequested(widget.mobileNumber));
  }

  /// Navigates to specified route
  void _navigateTo(BuildContext context, String route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(route);
    });
  }
}
