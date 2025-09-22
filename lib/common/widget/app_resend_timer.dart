// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

/// Timer State
class TimerState {
  const TimerState({
    required this.timeRemaining,
    required this.canResend,
  });

  final int timeRemaining;
  final bool canResend;

  TimerState copyWith({
    int? timeRemaining,
    bool? canResend,
  }) {
    return TimerState(
      timeRemaining: timeRemaining ?? this.timeRemaining,
      canResend: canResend ?? this.canResend,
    );
  }
}

/// Timer Cubit
class ResendTimerCubit extends Cubit<TimerState> {
  ResendTimerCubit(this.initialTimeInSeconds)
      : super(TimerState(
          timeRemaining: initialTimeInSeconds,
          canResend: initialTimeInSeconds <= 0,
        ));

  final int initialTimeInSeconds;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    
    if (initialTimeInSeconds <= 0) {
      emit(TimerState(timeRemaining: 0, canResend: true));
      return;
    }

    emit(TimerState(timeRemaining: initialTimeInSeconds, canResend: false));
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newTime = state.timeRemaining - 1;
      
      if (newTime > 0) {
        emit(TimerState(timeRemaining: newTime, canResend: false));
      } else {
        emit(TimerState(timeRemaining: 0, canResend: true));
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    emit(TimerState(
      timeRemaining: initialTimeInSeconds,
      canResend: initialTimeInSeconds <= 0,
    ));
    startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}


class AppResendTimer extends StatelessWidget {
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

  void _onResendTapped(BuildContext context, bool canResend) {
    if (canResend && isEnabled) {
      context.read<ResendTimerCubit>().resetTimer();
      onResendTapped?.call();
    }
  }

  String _formatTime(int seconds) {
    return "${seconds}s";
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocProvider(
      create: (context) => ResendTimerCubit(initialTimeInSeconds)..startTimer(),
      child: Center(
        child: BlocBuilder<ResendTimerCubit, TimerState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => _onResendTapped(context, state.canResend),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: resendText,
                      style: resendTextStyle ??
                          AppTypography.getResendText(context).copyWith(
                            color: state.canResend && isEnabled
                                ? appColors.primary // Theme-aware primary color
                                : appColors.onSurfaceVariant, // Theme-aware disabled color
                          ),
                    ),
                    if (!state.canResend) ...[
                      TextSpan(
                        text: " (${_formatTime(state.timeRemaining)})",
                        style: timerTextStyle ??
                            AppTypography.getResendText(context).copyWith(
                              color: appColors.onSurfaceVariant, // Theme-aware timer color
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Alternative implementation if you want to provide the Cubit externally
class AppResendTimerWithExternalCubit extends StatelessWidget {
  const AppResendTimerWithExternalCubit({
    super.key,
    this.onResendTapped,
    this.resendText = "Resend",
    this.timerTextStyle,
    this.resendTextStyle,
    this.isEnabled = true,
  });

  final VoidCallback? onResendTapped;
  final String resendText;
  final TextStyle? timerTextStyle;
  final TextStyle? resendTextStyle;
  final bool isEnabled;

  void _onResendTapped(BuildContext context, bool canResend) {
    if (canResend && isEnabled) {
      context.read<ResendTimerCubit>().resetTimer();
      onResendTapped?.call();
    }
  }

  String _formatTime(int seconds) {
    return "${seconds}s";
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Center(
      child: BlocBuilder<ResendTimerCubit, TimerState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => _onResendTapped(context, state.canResend),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: resendText,
                    style: resendTextStyle ??
                        AppTypography.getResendText(context).copyWith(
                          color: state.canResend && isEnabled
                              ? appColors.primary
                              : appColors.onSurfaceVariant,
                        ),
                  ),
                  if (!state.canResend) ...[
                    TextSpan(
                      text: " (${_formatTime(state.timeRemaining)})",
                      style: timerTextStyle ??
                          AppTypography.getResendText(context).copyWith(
                            color: appColors.onSurfaceVariant,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}