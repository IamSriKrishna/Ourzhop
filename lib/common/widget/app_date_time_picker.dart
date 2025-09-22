// // Flutter imports:
// import 'package:flutter/material.dart';

// // Project imports:
// import 'package:customer_app/core/themes/app_colors.dart';

// class AppDateTimePicker extends StatefulWidget {
//   const AppDateTimePicker({
//     super.key,
//     required this.selectedDateTime,
//     this.dateTime,
//   });

//   final void Function(DateTime date) selectedDateTime;
//   final DateTime? dateTime;

//   @override
//   State<AppDateTimePicker> createState() => _AppDateTimePickerState();
// }

// class _AppDateTimePickerState extends State<AppDateTimePicker> {
//   late DateTime date;

//   @override
//   void initState() {
//     if (widget.dateTime == null) {
//       date = DateTime.now();
//     } else {
//       date = widget.dateTime!;
//     }
//     super.initState();
//   }

//   // Get date from date picker
//   Future<DateTime?> pickDate() async {
//     final brandColors = context.appColors;

//     return await showDatePicker(
//       builder: (_, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: Theme.of(context).colorScheme.copyWith(
//                   surface: brandColors.surface,
//                   primary: brandColors.primary,
//                 ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: WidgetStateColor.resolveWith(
//                   (states) => states.contains(WidgetState.selected)
//                       ? brandColors.primary
//                       : brandColors.onSurface,
//                 ),
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//       context: context,
//       initialDate: date,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(DateTime.now().year + 1),
//     );
//   }

//   // Set the date that is taken from the user by date picker
//   void setDate(DateTime? newDate) {
//     if (newDate == null) return;

//     date = DateTime(
//       newDate.year,
//       newDate.month,
//       newDate.day,
//       date.hour,
//       date.minute,
//     );

//     widget.selectedDateTime(date);
//   }

//   // Get time from date picker
//   Future<TimeOfDay?> pickTime() async {
//     return await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(hour: date.hour, minute: date.minute),
//     );
//   }

//   // Set the time that is taken from the user by time picker
//   void setTime(TimeOfDay? newTime) {
//     if (newTime == null) return;
//     date = DateTime(
//       date.year,
//       date.month,
//       date.day,
//       newTime.hour,
//       newTime.minute,
//     );
//     widget.selectedDateTime(date);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final hours = date.hour.toString().padLeft(2, '0');
//     final minute = date.minute.toString().padLeft(2, '0');

//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextButton(
//             onPressed: () async {
//               DateTime? newDate = await pickDate();
//               setDate(newDate);
//               setState(() {});
//             },
//             child: Text(
//               "${date.year} / ${date.month} / ${date.day}",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25.0,
//               ),
//             ),
//           ),
//           const SizedBox(width: 15),
//           TextButton(
//             onPressed: () async {
//               TimeOfDay? newTime = await pickTime();
//               setTime(newTime);
//               setState(() {});
//             },
//             child: Text(
//               "$hours : $minute",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25.0,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// /// Legacy widget for backward compatibility
// @Deprecated('Use AppDateTimePicker instead')
// class DateTimePicker extends AppDateTimePicker {
//   const DateTimePicker({
//     super.key,
//     required super.selectedDateTime,
//     super.dateTime,
//   });
// }
