import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/validation/phone_validation_service.dart';
import 'package:customer_app/features/auth/presentation/base/auth_base.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:customer_app/features/auth/presentation/widgets/reusable_phone_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class LoginScreen extends BaseAuthScreen {
  final TextEditingController _phoneNumberController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget buildBody(BuildContext context, AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeaderSection(context, imageAsset: AppAsset.authHeader),
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
          onPressed: () => _handleLoginPressed(context),
          enabled: _isLoginEnabled(state),
        ),
      ],
    );
  }

  Widget _buildPhoneInputSection(BuildContext context, AuthState state) {
    return ReusablePhoneTextField(
      controller: _phoneNumberController,
      config: const PhoneTextFieldConfig(
        labelText: "Mobile Number",
        autoValidate: true,
      ),
      errorText: _getErrorText(state),
      onPhoneNumberChanged: (phoneNumber) =>
          _handlePhoneNumberChange(context, state),
    );
  }

  String? _getErrorText(AuthState state) {
    return state is ValidationError ? state.error : null;
  }

  bool _isLoginEnabled(AuthState state) {
    return state is! SignInLoading;
  }

  void _handlePhoneNumberChange(BuildContext context, AuthState state) {
    if (state is ValidationError) {
      context.read<AuthBloc>().add(ClearValidationError());
    }
  }

  void _handleLoginPressed(BuildContext context) {
    final phoneNumber = PhoneValidationService.parsePhoneNumber(
      _phoneNumberController.text,
    );
    Logger().e(phoneNumber.fullNumber.replaceAll(" ", ""));
    final validationResult =
        PhoneValidationService.validatePhoneNumber(phoneNumber);

    if (validationResult.isInvalid) {
      context.read<AuthBloc>().add(
            ValidationErrorTriggered(validationResult.errorMessage!),
          );
      return;
    }

    context.read<AuthBloc>().add(
          LoginRequested(phoneNumber.fullNumber.replaceAll(" ", "")),
        );
  }

  @override
  void handleAuthStateChange(BuildContext context, AuthState state) {
    switch (state) {
      case SignInSuccess():
        navigateTo(context, AppRoutes.otp,
            extra: _phoneNumberController.text.replaceAll(" ", ""));
        break;
      case SignInFailure():
        showErrorDialog(
          context,
          state.error,
          title: 'Login Error',
          onPressed: () => _handleLoginPressed(context),
        );
        break;
      default:
        break;
    }
  }

  @override
  bool isLoading(AuthState state) => state is SignInLoading;

  @override
  Widget buildLoadingOverlay(BuildContext context, AuthState state) {
    return const ProgressDialog(
      title: "Generating OTP...",
      isProgressed: true,
    );
  }
}
