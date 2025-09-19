// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details Screen',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Center(
        child: Text(
          'Details for item ID: $id',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Screen',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/profile/settings'),
          child: Text(
            'Go to Settings',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings Screen',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Center(
        child: Text(
          'Settings Page',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final UserPreferenceService authPreferenceService =
//         serviceLocator<UserPreferenceService>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Login Screen',
//           style: Theme.of(context).textTheme.displaySmall,
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await authPreferenceService.setLoggedIn(true);
//             context.go(AppRoutes.home);
//           },
//           child: Text(
//             'Login',
//             style: Theme.of(context).textTheme.displaySmall,
//           ),
//         ),
//       ),
//     );
//   }
// }
