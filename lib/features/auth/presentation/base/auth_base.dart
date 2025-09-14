import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_header_image.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class BaseAuthScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BaseAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: handleAuthStateChange,
      builder: (context, state) {
        return _buildScreenStructure(context, state);
      },
    );
  }

  Widget _buildScreenStructure(BuildContext context, AuthState state) {
    final appColors = context.appColors;

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: appColors.backgroundGradient),
            child: SafeArea(
              child: _buildScrollableContent(context, state),
            ),
          ),
        ),
        if (isLoading(state)) buildLoadingOverlay(context, state),
      ],
    );
  }

  Widget _buildScrollableContent(BuildContext context, AuthState state) {
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
            key: formKey,
            child: buildBody(context, state),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, AuthState state);
  void handleAuthStateChange(BuildContext context, AuthState state);
  bool isLoading(AuthState state);
  Widget buildLoadingOverlay(BuildContext context, AuthState state);

  Widget buildHeaderSection(
    BuildContext context, {
    required String imageAsset,
    double imageHeight = 160.0,
    double imageWidth = 160.0,
    double topPadding = 63.0,
    double bottomPadding = 32.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Center(
        child: AppHeaderImage(
          height: imageHeight,
          width: imageWidth,
          imageAsset: imageAsset,
        ),
      ),
    );
  }

  Widget buildTitleSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    double spacing = 11.0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.getLoginTitle(context)),
        SizedBox(height: spacing),
        Text(subtitle, style: AppTypography.getLoginSubtitle(context)),
      ],
    );
  }

  Widget buildActionButton(
    BuildContext context, {
    required String text,
    required VoidCallback onPressed,
    double height = 58.0,
    double bottomPadding = 20.0,
    bool enabled = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
          child: Text(text, style: AppTypography.getButtonText(context)),
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, String route, {Object? extra}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        if (extra != null) {
          context.go(route, extra: extra);
        } else {
          context.go(route);
        }
      }
    });
  }

  void showErrorDialog(
    BuildContext context,
    String error, {
    String title = 'Error',
    String buttonLabel = 'Try Again',
    VoidCallback? onPressed,
  }) {
    AppErrorDisplay.showDialog(
      context,
      error,
      title: title,
      buttonLabel: buttonLabel,
      onPressed: onPressed,
    );
  }
}
