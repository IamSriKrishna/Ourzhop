// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

/// Reusable scaffold component for authentication screens
///
/// This widget provides a consistent screen structure for auth screens
/// with gradient background, safe area, and scrollable content
class AppAuthScaffold extends StatelessWidget {
  const AppAuthScaffold({
    super.key,
    required this.child,
    this.formKey,
    this.showLoadingOverlay = false,
    this.loadingOverlay,
  });

  final Widget child;
  final GlobalKey<FormState>? formKey;
  final bool showLoadingOverlay;
  final Widget? loadingOverlay;

  @override
  Widget build(BuildContext context) {
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
        if (showLoadingOverlay && loadingOverlay != null) loadingOverlay!,
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
          child: formKey != null
              ? Form(
                  key: formKey,
                  child: child,
                )
              : child,
        ),
      ),
    );
  }
}
