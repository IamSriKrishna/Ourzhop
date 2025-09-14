// // ignore_for_file: deprecated_member_use

// import 'package:customer_app/core/themes/app_colors.dart';
// import 'package:flutter/material.dart';

// class PhoneNumberDisplayConfig {
//   final TextStyle? phoneNumberStyle;
//   final TextStyle? labelStyle;
//   final String editButtonText;
//   final IconData editIcon;
//   final Color? editButtonColor;
//   final double spacing;

//   const PhoneNumberDisplayConfig({
//     this.phoneNumberStyle,
//     this.labelStyle,
//     this.editButtonText = 'Edit',
//     this.editIcon = Icons.edit,
//     this.editButtonColor,
//     this.spacing = 8.0,
//   });
// }

// class ReusablePhoneNumberDisplay extends StatelessWidget {
//   final String phoneNumber;
//   final VoidCallback? onEditTapped;
//   final PhoneNumberDisplayConfig config;
//   final bool showEditButton;

//   const ReusablePhoneNumberDisplay({
//     super.key,
//     required this.phoneNumber,
//     this.onEditTapped,
//     this.config = const PhoneNumberDisplayConfig(),
//     this.showEditButton = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final appColors = context.appColors;

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//       decoration: BoxDecoration(
//         color: appColors.surface.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: appColors.outline.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.phone,
//             color: appColors.primary,
//             size: 20.0,
//           ),
//           SizedBox(width: config.spacing),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Phone Number',
//                   style: config.labelStyle ??
//                       theme.textTheme.bodySmall?.copyWith(
//                         color: appColors.onSurfaceVariant,
//                       ),
//                 ),
//                 const SizedBox(height: 4.0),
//                 Text(
//                   _formatPhoneNumber(phoneNumber),
//                   style: config.phoneNumberStyle ??
//                       theme.textTheme.bodyLarge?.copyWith(
//                         color: appColors.onSurface,
//                         fontWeight: FontWeight.w600,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//           if (showEditButton && onEditTapped != null)
//             TextButton.icon(
//               onPressed: onEditTapped,
//               icon: Icon(
//                 config.editIcon,
//                 size: 16.0,
//                 color: config.editButtonColor ?? appColors.primary,
//               ),
//               label: Text(
//                 config.editButtonText,
//                 style: theme.textTheme.bodySmall?.copyWith(
//                   color: config.editButtonColor ?? appColors.primary,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   String _formatPhoneNumber(String phoneNumber) {
//     if (phoneNumber.length >= 10) {
//       final cleaned = phoneNumber.replaceAll(RegExp(r'\D'), '');
//       if (cleaned.length == 10) {
//         return '${cleaned.substring(0, 5)} ${cleaned.substring(5)}';
//       }
//     }
//     return phoneNumber;
//   }
// }
