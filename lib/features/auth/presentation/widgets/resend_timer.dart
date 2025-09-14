
// import 'package:customer_app/constants/otp_constant.dart';
// import 'package:customer_app/core/themes/app_colors.dart';
// import 'package:flutter/material.dart';

// class ResendTimerConfig {
//   final int initialTimeInSeconds;
//   final String resendText;
//   final String timerTextFormat; 
//   final TextStyle? resendTextStyle;
//   final TextStyle? timerTextStyle;
//   final Color? resendButtonColor;
//   final bool showIcon;
//   final IconData icon;

//   const ResendTimerConfig({
//     this.initialTimeInSeconds = OtpConstants.defaultResendTimeSeconds,
//     this.resendText = 'Resend OTP',
//     this.timerTextFormat = 'Resend in {time}s',
//     this.resendTextStyle,
//     this.timerTextStyle,
//     this.resendButtonColor,
//     this.showIcon = false,
//     this.icon = Icons.refresh,
//   });
// }

// class ReusableResendTimer extends StatefulWidget {
//   final VoidCallback? onResendTapped;
//   final ResendTimerConfig config;
//   final bool enabled;

//   const ReusableResendTimer({
//     super.key,
//     this.onResendTapped,
//     this.config = const ResendTimerConfig(),
//     this.enabled = true,
//   });

//   @override
//   State<ReusableResendTimer> createState() => _ReusableResendTimerState();
// }

// class _ReusableResendTimerState extends State<ReusableResendTimer>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   int _remainingTime = 0;
//   bool _isTimerActive = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeTimer();
//     _startTimer();
//   }

//   void _initializeTimer() {
//     _remainingTime = widget.config.initialTimeInSeconds;
//     _animationController = AnimationController(
//       duration: Duration(seconds: widget.config.initialTimeInSeconds),
//       vsync: this,
//     );
    
//     _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.linear),
//     );
    
//     _animationController.addListener(_updateTimer);
//     _animationController.addStatusListener(_onAnimationStatusChanged);
//   }

//   void _updateTimer() {
//     if (mounted) {
//       setState(() {
//         _remainingTime = (_animation.value * widget.config.initialTimeInSeconds).ceil();
//       });
//     }
//   }

//   void _onAnimationStatusChanged(AnimationStatus status) {
//     if (status == AnimationStatus.completed) {
//       setState(() => _isTimerActive = false);
//     }
//   }

//   void _startTimer() {
//     if (mounted) {
//       setState(() => _isTimerActive = true);
//       _animationController.forward(from: 0.0);
//     }
//   }

//   void _resetTimer() {
//     _animationController.reset();
//     setState(() {
//       _remainingTime = widget.config.initialTimeInSeconds;
//     });
//     _startTimer();
//   }

//   void _handleResendTapped() {
//     if (!_isTimerActive && widget.enabled) {
//       widget.onResendTapped?.call();
//       _resetTimer();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final appColors = context.appColors;

//     if (_isTimerActive) {
//       return _buildTimerText(theme, appColors);
//     } else {
//       return _buildResendButton(theme, appColors);
//     }
//   }

//   Widget _buildTimerText(ThemeData theme, dynamic appColors) {
//     final timerText = widget.config.timerTextFormat.replaceAll('{time}', '$_remainingTime');
    
//     return Text(
//       timerText,
//       style: widget.config.timerTextStyle ??
//           theme.textTheme.bodyMedium?.copyWith(
//             color: appColors.onSurfaceVariant,
//           ),
//       textAlign: TextAlign.center,
//     );
//   }

//   Widget _buildResendButton(ThemeData theme, dynamic appColors) {
//     return TextButton(
//       onPressed: widget.enabled ? _handleResendTapped : null,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (widget.config.showIcon) ...[
//             Icon(
//               widget.config.icon,
//               size: 16.0,
//               color: widget.config.resendButtonColor ?? appColors.primary,
//             ),
//             const SizedBox(width: 4.0),
//           ],
//           Text(
//             widget.config.resendText,
//             style: widget.config.resendTextStyle ??
//                 theme.textTheme.bodyMedium?.copyWith(
//                   color: widget.enabled
//                       ? (widget.config.resendButtonColor ?? appColors.primary)
//                       : appColors.onSurfaceVariant.withOpacity(0.5),
//                   fontWeight: FontWeight.w600,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
