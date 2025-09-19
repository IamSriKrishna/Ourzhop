// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/validation/phone_input.dart';
import 'package:customer_app/common/widget/app_auth_header.dart';
import 'package:customer_app/common/widget/app_auth_title_section.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_loading_overlay.dart';
import 'package:customer_app/common/widget/app_phone_text_field.dart';
import 'package:customer_app/common/widget/app_primary_action_button.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/l10n/app_localizations.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:customer_app/features/login/presentation/bloc/login_event.dart';
import 'package:customer_app/features/login/presentation/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  final String? initialPhoneNumber;

  const LoginScreen({super.key, this.initialPhoneNumber});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Instance controllers with proper lifecycle management
  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocusNode;
  late final GlobalKey<FormState> _formKey;
  String _lastValidPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();

    // CRITICAL FIX: Pre-populate phone number if provided from OTP screen
    // and ensure LoginBloc starts in proper LoginInitial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final currentState = context.read<LoginBloc>().state;
        if (currentState is! LoginInitial) {
          // Reset to LoginInitial state if not already there
          context.read<LoginBloc>().add(const LoginHideValidationError());
        }

        // Pre-populate phone number if provided (e.g., from OTP screen edit)
        if (widget.initialPhoneNumber != null &&
            widget.initialPhoneNumber!.startsWith('+91')) {
          // Remove +91 prefix for display (show only 10 digits to user)
          final displayNumber = widget.initialPhoneNumber!.substring(3);
          _phoneController.text = displayNumber;
          // Update BLoC state with the display number (10 digits)
          context.read<LoginBloc>().add(LoginPhoneNumberChanged(displayNumber));
        }
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          current is SignInSuccess || current is SignInFailure,
      buildWhen: (previous, current) =>
          (previous is SignInLoading) != (current is SignInLoading),
      listener: _handleLoginStateChange,
      builder: (context, state) {
        final shouldShowLoading = _shouldShowLoading(state);
        return _buildMainScaffold(context, shouldShowLoading);
      },
    );
  }

  Widget _buildMainScaffold(BuildContext context, bool shouldShowLoading) {
    final appColors = context.appColors;

    return Stack(
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
            message: AppLocalizations.of(context)!.generatingOtpTitle,
          ),
      ],
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

        const SizedBox(height: 40.0),

        // Phone Input Section - Left aligned
        _buildPhoneInputSection(context),

        // Spacer to push button to bottom
        const Spacer(),

        // Bottom Section - Button
        _buildBottomSection(context),
      ],
    );
  }

  /// Builds the header section with image
  Widget _buildHeaderSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 40.0,
        bottom: 20.0,
      ),
      child: AppAuthHeader(imageAsset: AppAsset.authHeader),
    );
  }

  /// Builds the title section
  Widget _buildTitleSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppAuthTitleSection(
      title: l10n.loginScreenTitle,
      subtitle: l10n.loginScreenSubtitle,
    );
  }

  /// Builds the phone input section
  Widget _buildPhoneInputSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        // CRITICAL FIX: Always rebuild when we have LoginInitial state
        // This ensures the phone input is always visible for LoginInitial
        if (current is LoginInitial) return true;

        // Hide input when not in LoginInitial state
        if (current is! LoginInitial) return true;

        // For LoginInitial to LoginInitial transitions, rebuild when validation changes
        if (previous is LoginInitial) {
          return previous.shouldShowValidationError !=
                  current.shouldShowValidationError ||
              previous.phoneError != current.phoneError;
        }

        return false;
      },
      builder: (context, state) {
        // CRITICAL FIX: Always show phone input for LoginInitial state
        if (state is! LoginInitial) return const SizedBox.shrink();

        return AppPhoneTextField(
          key: const ValueKey('phone_input'),
          controller: _phoneController,
          focusNode: _phoneFocusNode,
          labelText: l10n.mobileNumberLabel,
          hintText: '0000000000',
          errorText: state.shouldShowValidationError
              ? _getErrorText(context, state.phoneError)
              : null,
          autofocus: true,
          onChanged: (digits) => _handlePhoneNumberChange(context, digits),
        );
      },
    );
  }

  /// Builds the bottom section with action button
  Widget _buildBottomSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            (previous is SignInLoading) != (current is SignInLoading),
        builder: (context, state) {
          final isEnabled = state is! SignInLoading;
          return AppPrimaryActionButton(
            text: l10n.verifyButtonTitle,
            onPressed: () => _handleLoginPressed(context),
            enabled: isEnabled,
          );
        },
      ),
    );
  }

  /// Handle phone number changes with instant feedback (no debounce)
  void _handlePhoneNumberChange(BuildContext context, String digits) {
    // Update phone number in BLoC - this triggers validation and auto-hides errors
    context.read<LoginBloc>().add(LoginPhoneNumberChanged(digits));
  }

  void _handleLoginPressed(BuildContext context) {
    final loginState = context.read<LoginBloc>().state as LoginInitial;

    // Use FormZ validation result directly - single source of truth
    if (!loginState.phoneNumber.isValid) {
      context.read<LoginBloc>().add(const LoginShowValidationError());
      _phoneFocusNode.requestFocus();
      return;
    }

    // Hide any previous validation errors
    context.read<LoginBloc>().add(const LoginHideValidationError());

    final fullPhoneNumber = '+91${loginState.phoneValue}';
    _lastValidPhoneNumber = fullPhoneNumber;
    context.read<LoginBloc>().add(LoginRequested(fullPhoneNumber));
  }

  void _handleLoginStateChange(BuildContext context, LoginState state) {
    final l10n = AppLocalizations.of(context)!;

    switch (state) {
      case SignInSuccess():
        _navigateToOtpScreen(context);
        break;
      case SignInFailure():
        _showLoginErrorDialog(context, state.error, l10n);
        break;
      default:
        break;
    }
  }

  /// Check if loading state should be shown
  bool _shouldShowLoading(LoginState state) {
    return state is SignInLoading;
  }

  /// Get localized error message for phone number validation
  String? _getErrorText(BuildContext context, PhoneValidationError? error) {
    if (error == null) return null;

    final l10n = AppLocalizations.of(context)!;
    switch (error) {
      case PhoneValidationError.empty:
        return l10n.phoneNumberRequired;
      case PhoneValidationError.tooShort:
        return l10n.phoneNumberTooShort;
      case PhoneValidationError.tooLong:
        return l10n.phoneNumberTooLong;
      case PhoneValidationError.invalid:
        return l10n.phoneNumberInvalid;
    }
  }

  void _navigateToOtpScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go(AppRoutes.otp, extra: _lastValidPhoneNumber);
      }
    });
  }

  void _showLoginErrorDialog(
      BuildContext context, String error, AppLocalizations l10n) {
    AppErrorDisplay.showSnackBar(
      context,
      error,
      duration: const Duration(seconds: 4),
    );
  }
}
