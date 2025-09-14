// import 'dart:async' show Timer;

// import 'package:flutter/material.dart';

// class PhoneDisplayCard extends StatelessWidget {
//   final String phoneNumber;
//   final VoidCallback? onEditTapped;
//   final bool showEditButton;

//   const PhoneDisplayCard({
//     super.key,
//     required this.phoneNumber,
//     this.onEditTapped,
//     this.showEditButton = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               _formatPhoneNumber(phoneNumber),
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//           if (showEditButton && onEditTapped != null)
//             GestureDetector(
//               onTap: onEditTapped,
//               child: Container(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Icon(
//                   Icons.edit,
//                   size: 20.0,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   String _formatPhoneNumber(String phoneNumber) {
//     // Format phone number to match the design
//     if (phoneNumber.startsWith('+91')) {
//       final number = phoneNumber.substring(3).trim();
//       if (number.length >= 10) {
//         return '+91 ${number.substring(0, 5)} ${number.substring(5)}';
//       }
//     }
//     return phoneNumber;
//   }
// }

// // File: lib/features/auth/presentation/widgets/resend_timer_widget.dart
// class ResendTimerWidget extends StatefulWidget {
//   final int initialTimeInSeconds;
//   final VoidCallback? onResendTapped;
//   final bool enabled;

//   const ResendTimerWidget({
//     super.key,
//     this.initialTimeInSeconds = 30,
//     this.onResendTapped,
//     this.enabled = true,
//   });

//   @override
//   State<ResendTimerWidget> createState() => _ResendTimerWidgetState();
// }

// class _ResendTimerWidgetState extends State<ResendTimerWidget>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Timer _timer;
//   int _remainingSeconds = 0;
//   bool _canResend = false;

//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }

//   void _startTimer() {
//     _remainingSeconds = widget.initialTimeInSeconds;
//     _canResend = false;

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           if (_remainingSeconds > 0) {
//             _remainingSeconds--;
//           } else {
//             _canResend = true;
//             _timer.cancel();
//           }
//         });
//       }
//     });
//   }

//   void _handleResendTap() {
//     if (_canResend && widget.enabled) {
//       widget.onResendTapped?.call();
//       _startTimer();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_canResend) {
//       return GestureDetector(
//         onTap: _handleResendTap,
//         child: Text(
//           'Resend',
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: 16.0,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       );
//     }

//     return Text(
//       'Resend (${_remainingSeconds}s)',
//       style: TextStyle(
//         color: Theme.of(context).primaryColor,
//         fontSize: 16.0,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
// }
