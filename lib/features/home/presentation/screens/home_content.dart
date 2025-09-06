import 'package:customer_app/constants/app_icons.dart';
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
    return FutureBuilder<UserModel?>(
      future: _authPrefs.getUser(),
      builder:  (ctx, snap) {
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
          body: CustomScrollView(
            slivers: [
              HomeContentWidgets.searchAndLocation(user.location!),
              HomeContentWidgets.appBar(),
              HomeContentWidgets.content(),
              SliverToBoxAdapter(
                child: Image.asset(AppImages.homeWallpaper),
              )
            ],
          ),
        );
      }
    );
  }
}
