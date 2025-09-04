// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_colors.dart';

Future<dynamic> deleteDialog(BuildContext context) {
  final brandColors = context.appColors;

  Future<dynamic> dialog = showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: brandColors.error, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_rounded, color: brandColors.error, size: 40),
            const SizedBox(width: 10),
            Text("Warning",
                textAlign: TextAlign.center,
                style: TextStyle(color: brandColors.onSurface)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Are you sure you want to delete this user?",
                style: TextStyle(color: brandColors.onSurfaceVariant)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No",
                      style: TextStyle(color: brandColors.onSurfaceVariant)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColors.error,
                    foregroundColor: brandColors.onError,
                  ),
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text("Yes"),
                )
              ],
            )
          ],
        ),
      );
    },
  );

  return dialog.then((res) => res ?? false);
}
