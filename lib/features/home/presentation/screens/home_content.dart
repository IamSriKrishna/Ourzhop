// lib/features/home/presentation/home_content.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/constants/app_language_constants.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/bloc/localization/localization_bloc.dart';
import 'package:customer_app/core/bloc/localization/localization_event.dart';
import 'package:customer_app/core/bloc/theme/theme_bloc.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/service_locator.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _authPrefs = serviceLocator<AuthPreferenceService>();

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    return FutureBuilder<UserModel?>(
      future: _authPrefs.getUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snap.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snap.error}')),
          );
        }
        final user = snap.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                onPressed: () =>
                    context.read<ThemeBloc>().add(const ThemeEvent()),
                icon: const Icon(Icons.color_lens),
              ),
              _buildLanguageDropdown(context, lang),
            ],
          ),
          body: Column(
            children: [
              // ── Button panel ──
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 12,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/details/123'),
                      child: const Text('Details 123'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.profile),
                      child: const Text('Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _authPrefs.logout();
                        if (context.mounted) context.go(AppRoutes.login);
                      },
                      child: Text('Logout ${user.mobileNumber}'),
                    ),
                  ],
                ),
              ),

              // ── Placeholder Content ──
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.store,
                        size: 64,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Welcome to Seller App!',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start managing your business here.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, String current) {
    return DropdownButton<String>(
      value: current,
      underline: const SizedBox.shrink(),
      items: LanguageConstants.languages.entries
          .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
          .toList(),
      onChanged: (lang) {
        if (lang != null) {
          context
              .read<LocalizationBloc>()
              .add(ChangeLanguageEvent(Locale(lang)));
        }
      },
    );
  }
}
