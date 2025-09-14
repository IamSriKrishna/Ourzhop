// Flutter imports:
import 'package:customer_app/common/widget/app_header_image.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_style.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _accountSetupFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildHeaderSection(context),
                    _buildHeading(context),
                    _buildNameInput(context),
                    _buildEmailInput(context),
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

                    // Spacer to push button to bottom
                    const Spacer(),

                    // Bottom Section - Button
                    _buildBottomSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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

  /// Builds the heading section of the screen
  Widget _buildHeading(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
                child: Text(
              context.tr.accountSetupPageTitle,
              style: AppTypography.getOtpTitle(context),
            )),
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
        ),
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
        const SizedBox(height: 20),
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
      ],
    );
  }

  /// Builds the bottom section with continue button
  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Continue button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _onAccountSetupPressed(context),
              style: Theme.of(context).elevatedButtonTheme.style,
              child: Text(
                context.tr.accountSetupButtonTitle,
              ),
            ),
          ),
        ],
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
