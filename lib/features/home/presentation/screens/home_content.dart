import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/home/widgets/async_user_wrapper.dart';
import 'package:customer_app/features/home/widgets/home_bloc_provider.dart';
import 'package:customer_app/features/home/widgets/home_scroll_view.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _authPrefs = serviceLocator<AuthPreferenceService>();

  @override
  Widget build(BuildContext context) {
    return AsyncUserWrapper(
      authPrefs: _authPrefs,
      builder: (context, user) {
        return HomeBlocProviders(
          child: HomeScrollView(user: user),
        );
      },
    );
  }
}
