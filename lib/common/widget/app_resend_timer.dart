// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// App Resend Timer Component
///
/// A reusable component that displays a resend timer with countdown functionality.
/// Used in OTP verification screens to manage resend attempts.
class AppResendTimer extends StatefulWidget {
  /// Creates an App Resend Timer component
  const AppResendTimer({
    super.key,
    required this.initialTimeInSeconds,
    this.onResendTapped,
    this.resendText = "Resend",
    this.timerTextStyle,
    this.resendTextStyle,
    this.isEnabled = true,
  });

  /// Initial countdown time in seconds
  final int initialTimeInSeconds;

  /// Callback when resend is tapped (when timer is finished)
  final VoidCallback? onResendTapped;

  /// Text to display for resend action
  final String resendText;

  /// Custom text style for timer
  final TextStyle? timerTextStyle;

  /// Custom text style for resend text
  final TextStyle? resendTextStyle;

  /// Whether the component is enabled
  final bool isEnabled;

  @override
  State<AppResendTimer> createState() => _AppResendTimerState();
}

class _AppResendTimerState extends State<AppResendTimer> {
  late int _timeRemaining;
  Timer? _timer;
  bool get _canResend => _timeRemaining <= 0;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.initialTimeInSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _onResendTapped() {
    if (_canResend && widget.isEnabled) {
      setState(() {
        _timeRemaining = widget.initialTimeInSeconds;
      });
      _startTimer();
      widget.onResendTapped?.call();
    }
  }

  String _formatTime(int seconds) {
    return "${seconds}s";
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Center(
      child: GestureDetector(
        onTap: _onResendTapped,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.resendText,
                style: widget.resendTextStyle ??
                    AppTypography.getResendText(context).copyWith(
                      color: _canResend && widget.isEnabled
                          ? appColors.primary // Theme-aware primary color
                          : appColors
                              .onSurfaceVariant, // Theme-aware disabled color
                    ),
              ),
              if (!_canResend) ...[
                TextSpan(
                  text: " (${_formatTime(_timeRemaining)})",
                  style: widget.timerTextStyle ??
                      AppTypography.getResendText(context).copyWith(
                        color: appColors
                            .onSurfaceVariant, // Theme-aware timer color
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
