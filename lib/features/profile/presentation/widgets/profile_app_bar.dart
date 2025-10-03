
import 'package:customer_app/features/profile/presentation/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final bool showEditButton;
  final VoidCallback? onEditPressed;
  final Color? backgroundColor;
  final List<Widget>? additionalActions;

  const ProfileAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.showEditButton = false,
    this.onEditPressed,
    this.backgroundColor,
    this.additionalActions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: backgroundColor ?? colorScheme.primary,
      elevation: 0,
      toolbarHeight: size.height * 0.08,
      leadingWidth: size.width * 0.15,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? Center(
              child: CircularIconButton(
                icon: Icons.arrow_back,
                onTap: () => context.pop(),
              ),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
          height: 1.2,
        ),
      ),
      actions: [
        if (showEditButton)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircularIconButton(
              icon: Icons.edit,
              onTap: onEditPressed ?? () {},
            ),
          ),
        if (additionalActions != null) ...additionalActions!,
      ],
    );
  }
}