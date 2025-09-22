// // Flutter imports:
// import 'package:flutter/material.dart';

// // Project imports:
// import 'package:customer_app/common/widget/app_error_display.dart';
// import 'package:customer_app/core/themes/app_colors.dart';

// /// Showcase screen demonstrating all error display options
// /// This file serves as documentation and testing for the error system
// class AppErrorShowcaseScreen extends StatelessWidget {
//   const AppErrorShowcaseScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final brandColors = context.appColors;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Error Display Options'),
//         backgroundColor: brandColors.surface,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Header
//             Text(
//               'Modern Error Display System',
//               style: theme.textTheme.headlineMedium?.copyWith(
//                 color: brandColors.onSurface,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Choose the right error display for different scenarios',
//               style: theme.textTheme.bodyLarge?.copyWith(
//                 color: brandColors.onSurfaceVariant,
//               ),
//             ),
//             const SizedBox(height: 32),

//             // SnackBar Demo
//             _buildSection(
//               context,
//               '1. SnackBar (Recommended for most errors)',
//               'Non-intrusive, temporary, perfect for network errors',
//               [
//                 ElevatedButton(
//                   onPressed: () => AppErrorDisplay.showSnackBar(
//                     context,
//                     'Network connection failed. Please check your internet.',
//                   ),
//                   child: const Text('Show Simple SnackBar'),
//                 ),
//                 const SizedBox(width: 8),
//                 OutlinedButton(
//                   onPressed: () => AppErrorDisplay.showSnackBar(
//                     context,
//                     'Failed to save changes.',
//                     onRetry: () {
//                       // Retry action
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Retrying...')),
//                       );
//                     },
//                   ),
//                   child: const Text('SnackBar with Retry'),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),

//             // Simple Dialog Demo
//             _buildSection(
//               context,
//               '2. Simple Dialog (For critical errors)',
//               'Clean, focused, single action - no confusing choices',
//               [
//                 ElevatedButton(
//                   onPressed: () => AppErrorDisplay.showDialog(
//                     context,
//                     'Your session has expired. Please log in again.',
//                     title: 'Session Expired',
//                   ),
//                   child: const Text('Show Simple Dialog'),
//                 ),
//                 const SizedBox(width: 8),
//                 OutlinedButton(
//                   onPressed: () => AppErrorDisplay.showDialog(
//                     context,
//                     'OTP has expired. Please request a new one.',
//                     title: 'OTP Expired',
//                     buttonLabel: 'Request New OTP',
//                     onPressed: () {
//                       // Action when button pressed
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Requesting new OTP...')),
//                       );
//                     },
//                   ),
//                   child: const Text('Dialog with Action'),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),

//             // Banner Demo
//             _buildSection(
//               context,
//               '3. Inline Banner (For persistent issues)',
//               'Persistent, non-blocking, good for form errors',
//               [
//                 ElevatedButton(
//                   onPressed: () => _showBannerDemo(context),
//                   child: const Text('Show Banner Example'),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),

//             // Bottom Sheet Demo
//             _buildSection(
//               context,
//               '4. Bottom Sheet (For complex errors)',
//               'Detailed information, multiple error messages',
//               [
//                 ElevatedButton(
//                   onPressed: () => AppErrorDisplay.showBottomSheet(
//                     context,
//                     'Failed to upload product images.',
//                     details: [
//                       'Image size too large (max 5MB)',
//                       'Invalid file format (JPG, PNG only)',
//                       'Network connection unstable',
//                     ],
//                     onRetry: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Retrying upload...')),
//                       );
//                     },
//                   ),
//                   child: const Text('Show Bottom Sheet'),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),

//             // Toast Demo
//             _buildSection(
//               context,
//               '5. Toast (For quick feedback)',
//               'Minimal, auto-dismissing, non-blocking',
//               [
//                 ElevatedButton(
//                   onPressed: () => AppErrorToast.show(
//                     context,
//                     'Invalid email format',
//                   ),
//                   child: const Text('Show Toast'),
//                 ),
//                 const SizedBox(width: 8),
//                 OutlinedButton(
//                   onPressed: () => AppErrorToast.show(
//                     context,
//                     'Product saved to drafts',
//                     duration: const Duration(seconds: 5),
//                   ),
//                   child: const Text('Long Toast'),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),

//             // Comparison with old approach
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: brandColors.successContainer.withValues(alpha: 0.3),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: brandColors.success.withValues(alpha: 0.3),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.check_circle_outline,
//                         color: brandColors.success,
//                         size: 24,
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Improvements over RetryDialog:',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           color: brandColors.onSurface,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   ...([
//                     '✓ Simpler UX - Single action instead of Cancel/Retry',
//                     '✓ Material 3 design - Modern, clean aesthetics',
//                     '✓ Multiple options - Right display for each scenario',
//                     '✓ Consistent theming - Uses app colors properly',
//                     '✓ Better accessibility - Clear icons and labels',
//                   ].map((benefit) => Padding(
//                         padding: const EdgeInsets.only(bottom: 4),
//                         child: Text(
//                           benefit,
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: brandColors.onSurface,
//                           ),
//                         ),
//                       ))),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(
//     BuildContext context,
//     String title,
//     String description,
//     List<Widget> actions,
//   ) {
//     final theme = Theme.of(context);
//     final brandColors = context.appColors;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: theme.textTheme.titleLarge?.copyWith(
//             color: brandColors.onSurface,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           description,
//           style: theme.textTheme.bodyMedium?.copyWith(
//             color: brandColors.onSurfaceVariant,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: actions,
//         ),
//       ],
//     );
//   }

//   void _showBannerDemo(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => const _BannerDemoScreen(),
//       ),
//     );
//   }
// }

// /// Demo screen showing persistent error banner
// class _BannerDemoScreen extends StatefulWidget {
//   const _BannerDemoScreen();

//   @override
//   State<_BannerDemoScreen> createState() => _BannerDemoScreenState();
// }

// class _BannerDemoScreenState extends State<_BannerDemoScreen> {
//   bool _showBanner = true;

//   @override
//   Widget build(BuildContext context) {
//     final brandColors = context.appColors;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Banner Demo'),
//         backgroundColor: brandColors.surface,
//       ),
//       body: Column(
//         children: [
//           if (_showBanner)
//             AppErrorBanner(
//               message:
//                   'Unable to connect to server. Some features may not work properly.',
//               onRetry: () {
//                 // Simulate retry
//                 setState(() {
//                   _showBanner = false;
//                 });
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text('Connection restored!'),
//                     backgroundColor: Colors.green,
//                   ),
//                 );
//               },
//               onDismiss: () {
//                 setState(() {
//                   _showBanner = false;
//                 });
//               },
//             ),
//           Expanded(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'This is your main app content.\nThe banner above is persistent and non-blocking.',
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   if (!_showBanner)
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           _showBanner = true;
//                         });
//                       },
//                       child: const Text('Show Banner Again'),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
