// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_style.dart';

/// App Bottom Text Prompt Component
///
/// A reusable component that displays a text prompt with a clickable action text.
/// Used for "Already have an account? Login" type prompts.
class AppBottomTextPrompt extends StatelessWidget {
  /// Creates an App Bottom Text Prompt component
  const AppBottomTextPrompt({
    super.key,
    required this.promptText,
    required this.actionText,
    this.onActionTapped,
    this.promptTextStyle,
    this.actionTextStyle,
    this.spacing = 4.0,
    this.alignment = MainAxisAlignment.center,
  });

  /// The prompt text (e.g., "Already have an account?")
  final String promptText;

  /// The action text (e.g., "Login")
  final String actionText;

  /// Callback when action text is tapped
  final VoidCallback? onActionTapped;

  /// Custom text style for prompt text
  final TextStyle? promptTextStyle;

  /// Custom text style for action text
  final TextStyle? actionTextStyle;

  /// Spacing between prompt and action text
  final double spacing;

  /// Alignment of the text prompt
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingLg,
        vertical: AppDesignTokens.spacingSm,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            promptText,
            style: promptTextStyle ??
                AppTypography.getPromptText(context), // Exact design specs
            textAlign: TextAlign.center,
          ),
          SizedBox(height: spacing),
          GestureDetector(
            onTap: onActionTapped,
            child: Text(
              actionText,
              style: actionTextStyle ??
                  AppTypography.getLinkText(context), // Exact design specs
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
