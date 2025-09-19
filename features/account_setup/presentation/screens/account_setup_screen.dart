// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/validation/email_input.dart';
import 'package:customer_app/common/validation/name_input.dart';
import 'package:customer_app/common/widget/app_auth_header.dart';
import 'package:customer_app/common/widget/app_auth_title_section.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_loading_overlay.dart';
import 'package:customer_app/common/widget/app_primary_action_button.dart';
import 'package:customer_app/common/widget/app_text_field.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/l10n/app_localizations.dart';
import 'package:customer_app/core/themes/app_asset.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/account_setup/presentation/bloc/account_setup_bloc.dart';
import 'package:customer_app/features/account_setup/presentation/bloc/account_setup_event.dart';
import 'package:customer_app/features/account_setup/presentation/bloc/account_setup_state.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  State<AccountSetupScreen> createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  // 1. Controllers and keys declaration (late final for lifecycle)
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final GlobalKey<FormState> _formKey;

  // 2. State variables
  String _lastValidName = '';
  String _lastValidEmail = '';

  @override
  void initState() {
    super.initState();
    // 3. Initialize controllers
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // 4. CRITICAL: Always dispose controllers
    _nameController.dispose();
    _emailController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 5. BlocConsumer for state management
    return BlocConsumer<AccountSetupBloc, AccountSetupState>(
      listenWhen: (previous, current) =>
          current is AccountSetupSuccess || current is AccountSetupFailure,
      buildWhen: (previous, current) =>
          (previous is AccountSetupLoading) !=
              (current is AccountSetupLoading) ||
          (previous is AccountSetupInitial &&
              current is AccountSetupInitial &&
              (previous.shouldShowValidationError !=
                      current.shouldShowValidationError ||
                  previous.nameError != current.nameError ||
                  previous.emailError != current.emailError)),
      listener: _handleAccountSetupStateChange,
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
            message:
                AppLocalizations.of(context)!.accountSetupProgressVerifying,
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

  // 6. Visual section segregation with separate build methods
  Widget _buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderSection(context), // Header Section - Centered
        _buildTitleSection(context), // Title Section - Left aligned
        const SizedBox(height: 40.0),
        _buildNameInputSection(context), // Name Input Section - Left aligned
        _buildEmailInputSection(context), // Email Input Section - Left aligned
        const Spacer(), // Spacer to push button to bottom
        _buildBottomSection(context), // Bottom Section - Button
      ],
    );
  }

  /// Check if loading state should be shown
  bool _shouldShowLoading(AccountSetupState state) {
    return state is AccountSetupLoading;
  }

  /// Builds the header section with image (following login pattern)
  Widget _buildHeaderSection(BuildContext context) {
    return AppAuthHeader(
      imageAsset: AppAsset.authHeader,
      imageHeight: 160.0,
      imageWidth: 160.0,
      topPadding: 40.0,
      bottomPadding: 20.0,
    );
  }

  /// Builds the title section (following login pattern)
  Widget _buildTitleSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppAuthTitleSection(
      title: l10n.accountSetupPageTitle,
      subtitle: l10n.accountSetupPageSubTitle,
      spacing: 11.0,
      alignment: CrossAxisAlignment.start,
    );
  }

  /// Builds the name input section with validation (following login pattern)
  Widget _buildNameInputSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      buildWhen: (previous, current) {
        // Always rebuild when entering/leaving AccountSetupInitial state
        if (previous is! AccountSetupInitial &&
            current is AccountSetupInitial) {
          return true;
        }
        if (previous is AccountSetupInitial &&
            current is! AccountSetupInitial) {
          return true;
        }

        // For AccountSetupInitial to AccountSetupInitial transitions, rebuild when:
        // 1. Validation error state changes
        // 2. Name error type changes
        if (previous is AccountSetupInitial && current is AccountSetupInitial) {
          return previous.shouldShowValidationError !=
                  current.shouldShowValidationError ||
              previous.nameError != current.nameError;
        }

        return false;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                l10n.accountSetupName,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _nameController,
              focusNode: _nameFocusNode,
              hintText: l10n.accountSetupNameHint,
              errorText: state is AccountSetupInitial &&
                      state.shouldShowValidationError
                  ? _getNameErrorText(context, state.nameError)
                  : null,
              onChanged: (name) => _handleNameChange(context, name),
            ),
          ],
        );
      },
    );
  }

  /// Builds the email input section with validation (following login pattern)
  Widget _buildEmailInputSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<AccountSetupBloc, AccountSetupState>(
      buildWhen: (previous, current) {
        // Always rebuild when entering/leaving AccountSetupInitial state
        if (previous is! AccountSetupInitial &&
            current is AccountSetupInitial) {
          return true;
        }
        if (previous is AccountSetupInitial &&
            current is! AccountSetupInitial) {
          return true;
        }

        // For AccountSetupInitial to AccountSetupInitial transitions, rebuild when:
        // 1. Validation error state changes
        // 2. Email error type changes
        if (previous is AccountSetupInitial && current is AccountSetupInitial) {
          return previous.shouldShowValidationError !=
                  current.shouldShowValidationError ||
              previous.emailError != current.emailError;
        }

        return false;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                l10n.accountSetupEmail,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 10),
            AppTextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              hintText: l10n.accountSetupEmailHint,
              keyboardType: TextInputType.emailAddress,
              errorText: state is AccountSetupInitial &&
                      state.shouldShowValidationError
                  ? _getEmailErrorText(context, state.emailError)
                  : null,
              onChanged: (email) => _handleEmailChange(context, email),
            ),
          ],
        );
      },
    );
  }

  /// Builds the bottom section with action button (following login pattern)
  Widget _buildBottomSection(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: BlocBuilder<AccountSetupBloc, AccountSetupState>(
        buildWhen: (previous, current) =>
            (previous is AccountSetupLoading) !=
            (current is AccountSetupLoading),
        builder: (context, state) {
          final isEnabled = state is! AccountSetupLoading;
          return AppPrimaryActionButton(
            text: l10n.accountSetupButtonTitle,
            onPressed: () => _handleAccountSetupPressed(context),
            enabled: isEnabled,
          );
        },
      ),
    );
  }

  /// Handle name changes with instant feedback (following login pattern)
  void _handleNameChange(BuildContext context, String name) {
    // Update name in BLoC - this triggers validation and auto-hides errors
    context.read<AccountSetupBloc>().add(AccountSetupNameChanged(name));
  }

  /// Handle email changes with instant feedback (following login pattern)
  void _handleEmailChange(BuildContext context, String email) {
    // Update email in BLoC - this triggers validation and auto-hides errors
    context.read<AccountSetupBloc>().add(AccountSetupEmailChanged(email));
  }

  // 7. Handle business logic in separate methods
  void _handleAccountSetupPressed(BuildContext context) {
    final accountSetupState =
        context.read<AccountSetupBloc>().state as AccountSetupInitial;

    // Use FormZ validation result directly
    if (!accountSetupState.isValid) {
      context
          .read<AccountSetupBloc>()
          .add(const AccountSetupShowValidationError());
      if (!accountSetupState.name.isValid) {
        _nameFocusNode.requestFocus();
      } else {
        _emailFocusNode.requestFocus();
      }
      return;
    }

    // Hide any previous validation errors
    context
        .read<AccountSetupBloc>()
        .add(const AccountSetupHideValidationError());

    _lastValidName = accountSetupState.nameValue;
    _lastValidEmail = accountSetupState.emailValue;
    context
        .read<AccountSetupBloc>()
        .add(AccountSetupRequested(_lastValidName, _lastValidEmail));
  }

  void _handleAccountSetupStateChange(
      BuildContext context, AccountSetupState state) {
    final l10n = AppLocalizations.of(context)!;

    switch (state) {
      case AccountSetupSuccess():
        _navigateToLocationSelection(context);
        break;
      case AccountSetupFailure():
        _showAccountSetupErrorDialog(context, state.error, l10n);
        break;
      default:
        break;
    }
  }

  /// Get localized error message for name validation
  String? _getNameErrorText(BuildContext context, NameValidationError? error) {
    if (error == null) return null;

    final l10n = AppLocalizations.of(context)!;
    switch (error) {
      case NameValidationError.empty:
        return l10n.accountSetupNameRequired;
      case NameValidationError.tooShort:
        return l10n.nameValidationTooShort;
      case NameValidationError.tooLong:
        return l10n.nameValidationTooLong;
      case NameValidationError.invalid:
        return l10n.nameValidationInvalid;
    }
  }

  /// Get localized error message for email validation
  String? _getEmailErrorText(
      BuildContext context, EmailValidationError? error) {
    if (error == null) return null;

    final l10n = AppLocalizations.of(context)!;
    switch (error) {
      case EmailValidationError.empty:
        return l10n.accountSetupEmailRequired;
      case EmailValidationError.invalid:
        return l10n.accountSetupEmailInvalid;
      case EmailValidationError.tooLong:
        return l10n.emailValidationTooLong;
    }
  }

  void _navigateToLocationSelection(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.go(AppRoutes.locationSelection);
      }
    });
  }

  void _showAccountSetupErrorDialog(
      BuildContext context, String error, AppLocalizations l10n) {
    AppErrorDisplay.showSnackBar(
      context,
      error,
      duration: const Duration(seconds: 4),
    );
  }
}
