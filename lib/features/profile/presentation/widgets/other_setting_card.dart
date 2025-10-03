// ignore_for_file: deprecated_member_use

import 'package:customer_app/constants/app_icons.dart';
import 'package:customer_app/features/profile/presentation/widgets/setting_item_card.dart';
import 'package:flutter/material.dart';

class OtherSettingCard extends StatelessWidget {
  const OtherSettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;

    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
        horizontal: size.width * 0.04,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
            border: isDark
                ? Border.all(
                    color: colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  )
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              SettingItemCard(
                icon: AppIcons.profileDetails,
                title: "Profile Details",
                subtitle: "Manage your personal information",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.location,
                title: "Delivery Location",
                subtitle: "Add or edit delivery addresses",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.payment,
                title: "Payment Method",
                subtitle: "Manage your payment options",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.promo,
                title: "Promo Code",
                subtitle: "View and apply discounts",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.notifications,
                title: "Notifications",
                subtitle: "Control your notification preferences",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.help,
                title: "Help",
                subtitle: "Get support and FAQs",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.settings,
                title: "Settings",
                subtitle: "App preferences and options",
                onTap: () {},
              ),
              SettingItemCard(
                icon: AppIcons.info,
                title: "About",
                subtitle: "App version and information",
                onTap: () {},
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
