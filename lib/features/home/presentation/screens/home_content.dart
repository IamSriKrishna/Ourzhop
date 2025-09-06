import 'package:customer_app/constants/app_images.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/home/widgets/home_content_widgets.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return FutureBuilder<UserModel?>(
      future: _authPrefs.getUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
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

        return Scaffold(
          backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          body: CustomScrollView(
            slivers: [
              HomeContentWidgets.searchAndLocation(user.location!, context),
              HomeContentWidgets.appBar(context),
              HomeContentWidgets.content(context),
              SliverToBoxAdapter(
                child: Image.asset(AppImages.homeWallpaper),
              )
            ],
          ),
        );
      },
    );
  }
}