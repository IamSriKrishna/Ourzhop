
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';

class AsyncUserWrapper extends StatelessWidget {
  final AuthPreferenceService authPrefs;
  final Widget Function(BuildContext context, UserModel user) builder;

  const AsyncUserWrapper({
    super.key,
    required this.authPrefs,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FutureBuilder<UserModel?>(
      future: authPrefs.getUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            ),
          );
        }
        
        if (snap.hasError) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: Text(
                'Error: ${snap.error}',
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          );
        }
        
        final user = snap.data!;
        return builder(ctx, user);
      },
    );
  }
}
