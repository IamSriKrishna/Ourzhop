// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/models/user_model.dart';
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_widgets.dart';
import 'package:customer_app/service_locator.dart';

// Package imports:

// Project imports:

class CartContent extends StatefulWidget {
  const CartContent({super.key});

  @override
  State<CartContent> createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> {
  final _authPrefs = serviceLocator<UserPreferenceService>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FutureBuilder<UserModel?>(
      future: _authPrefs.getUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Container(
            color: colorScheme.surface,
            child: Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            ),
          );
        }
        if (snap.hasError) {
          return Container(
            color: colorScheme.surface,
            child: Center(
              child: Text(
                'Error: ${snap.error}',
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          );
        }
        final user = snap.data!;

        return Container(
          color: colorScheme.surface,
          child: CustomScrollView(
            slivers: [
              CartContentWidgets.appBar(context),
              CartContentWidgets.emptyCartContent(context)
            ],
          ),
        );
      },
    );
  }
}
