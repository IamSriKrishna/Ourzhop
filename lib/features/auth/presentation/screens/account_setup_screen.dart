// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/dialog/progress_dialog.dart';
import 'package:customer_app/common/validators/validators.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_text_field.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/app_extension.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_state.dart';

class AccountSetupScreen extends StatelessWidget {
  AccountSetupScreen({super.key});
  final GlobalKey<FormState> _accountSetupFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _accountSetupFormKey,
            child: Column(
              children: <Widget>[
                _buildHeading(context),
                _buildNameInput(context),
                _buildEmailInput(context),
                _buildAccountSetupButton(context),
                const SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AccountSetupSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.go(
                          AppRoutes.locationSelection,
                        );
                      });
                    } else if (state is AccountSetupFailure) {
                      AppErrorDisplay.showDialog(
                        context,
                        state.error,
                        title: 'Account Setup Failed',
                        buttonLabel: 'Try Again',
                        onPressed: () => _onAccountSetupPressed(context),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AccountSetupLoading) {
                      return ProgressDialog(
                        title: context.tr.accountSetupProgressVerifying,
                        isProgressed: true,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the heading section of the screen
  Widget _buildHeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Text(
            context.tr.accountSetupPageTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            context.tr.accountSetupPageSubTitle,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  /// Builds the Name input section
  Widget _buildNameInput(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            context.tr.accountSetupName,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: screenWidth * 0.9,
          child: AppTextField(
            controller: _nameController,
            hintText: context.tr.accountSetupNameHint,
            validator: Validators.validateName,
            textStyle: Theme.of(context).textTheme.displayMedium,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 18,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the Email input section
  Widget _buildEmailInput(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            context.tr.accountSetupEmail,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: screenWidth * 0.9,
          child: AppTextField(
            controller: _emailController,
            hintText: context.tr.accountSetupEmailHint,
            validator: Validators.validateEmail,
            textStyle: Theme.of(context).textTheme.displayMedium,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 18,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  /// Builds the account setup button
  Widget _buildAccountSetupButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 56,
      width: screenWidth * 0.9,
      child: ElevatedButton(
        onPressed: () => _onAccountSetupPressed(context),
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(
          context.tr.accountSetupButtonTitle,
        ),
      ),
    );
  }

  /// Handles the account setup button press
  void _onAccountSetupPressed(BuildContext context) {
    if (!(_accountSetupFormKey.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(
        AccountSetupRequested(_nameController.text, _emailController.text));
  }
}
