import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/core/utils/phone_number_formatter.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/profile/presentation/widgets/other_setting_card.dart';
import 'package:customer_app/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:customer_app/features/profile/presentation/widgets/profile_async_builder.dart';
import 'package:customer_app/features/profile/presentation/widgets/user_info_card.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authPrefs = serviceLocator<AuthPreferenceService>();

    return AsyncBuilder<UserModel?>(
      future: authPrefs.getUser(),
      builder: (context, user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('No user data found')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              ProfileAppBar(
                title: "Profile",
                showBackButton: true,
                showEditButton: true,
                onEditPressed: () {},
              ),
              UserInfoCard(
                name: user.name ?? "User",
                subtitle: PhoneFormatter.formatPhoneNumber(user.mobileNumber),
              ),
              OtherSettingCard()
            ],
          ),
        );
      },
    );
  }
}
