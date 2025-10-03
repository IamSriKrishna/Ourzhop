import 'package:flutter/material.dart';

class LogoutConfirmationDialog {
  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Logout'),
              content: const Text(
                'Going back will log you out. Are you sure you want to continue?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
