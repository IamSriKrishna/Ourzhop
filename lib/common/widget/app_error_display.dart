// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

/// Error display system with multiple options for different scenarios
class AppErrorDisplay {
  const AppErrorDisplay._();

  /// Show a simple snackbar for non-critical errors
  /// Best for: Network errors, validation failures, temporary issues
  static void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onRetry,
    String? retryLabel,
  }) {
    final brandColors = context.appColors;
    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: brandColors.onErrorContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: brandColors.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: brandColors.errorContainer,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: duration,
        action: onRetry != null
            ? SnackBarAction(
                label: retryLabel ?? 'Retry',
                onPressed: onRetry,
                textColor: brandColors.error,
              )
            : null,
      ),
    );
  }

  /// Show a simple dialog for critical errors that need acknowledgment
  /// Best for: Critical errors, auth failures, system errors
  static Future<void> showDialog(
    BuildContext context,
    String message, {
    String title = 'Error',
    String buttonLabel = 'OK',
    VoidCallback? onPressed,
  }) async {
    final brandColors = context.appColors;
    final theme = Theme.of(context);

    return showAdaptiveDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: Icon(
          Icons.info_outline_rounded,
          color: brandColors.error,
          size: 32,
        ),
        title: Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: brandColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: brandColors.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: brandColors.primary,
              foregroundColor: brandColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(buttonLabel),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  /// Show a bottom sheet for detailed error information
  /// Best for: Complex errors, multiple error messages, debugging info
  static Future<void> showBottomSheet(
    BuildContext context,
    String message, {
    String title = 'Error Details',
    List<String>? details,
    VoidCallback? onRetry,
    String? retryLabel,
  }) async {
    final brandColors = context.appColors;
    final theme = Theme.of(context);

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: brandColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: brandColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon and title
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: brandColors.error,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: brandColors.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Main message
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: brandColors.errorContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: brandColors.error.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      message,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: brandColors.onSurface,
                      ),
                    ),
                  ),

                  // Details if provided
                  if (details != null && details.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: brandColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Details',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: brandColors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...details.map(
                            (detail) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                '• $detail',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: brandColors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: brandColors.onSurface,
                            side: BorderSide(
                              color: brandColors.outline,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: const Text('Close'),
                        ),
                      ),
                      if (onRetry != null) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onRetry.call();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: brandColors.primary,
                              foregroundColor: brandColors.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(retryLabel ?? 'Retry'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Inline error banner widget for persistent error states
/// Best for: Form validation errors, persistent connectivity issues
class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({
    super.key,
    required this.message,
    this.onRetry,
    this.onDismiss,
    this.retryLabel,
    this.showDismiss = true,
  });

  /// Error message to display
  final String message;

  /// Callback when retry button is pressed
  final VoidCallback? onRetry;

  /// Callback when dismiss button is pressed
  final VoidCallback? onDismiss;

  /// Label for retry button
  final String? retryLabel;

  /// Whether to show dismiss button
  final bool showDismiss;

  @override
  Widget build(BuildContext context) {
    final brandColors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: brandColors.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: brandColors.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: brandColors.error,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: brandColors.onErrorContainer,
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      foregroundColor: brandColors.error,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(retryLabel ?? 'Retry'),
                  ),
                ],
              ],
            ),
          ),
          if (showDismiss) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: onDismiss,
              icon: Icon(
                Icons.close_rounded,
                color: brandColors.error,
                size: 20,
              ),
              iconSize: 20,
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
    );
  }
}

/// Toast-like error message that auto-dismisses
/// Best for: Quick feedback, non-critical errors
class AppErrorToast {
  static OverlayEntry? _currentOverlay;

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    // Remove any existing toast
    hide();

    final brandColors = context.appColors;
    final theme = Theme.of(context);

    _currentOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: brandColors.errorContainer,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  color: brandColors.error,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: brandColors.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_currentOverlay!);

    // Auto-dismiss
    Future.delayed(duration, () {
      hide();
    });
  }

  static void hide() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
