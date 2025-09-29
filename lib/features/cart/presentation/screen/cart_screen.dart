// ignore_for_file: deprecated_member_use

import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_checkout_bar.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_content.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_empty_state.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _authPrefs = serviceLocator<AuthPreferenceService>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: _authPrefs.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _LoadingState();
        }

        if (snapshot.hasError) {
          return _ErrorState(error: snapshot.error.toString());
        }

        return const _CartScreenContent();
      },
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  const _CartScreenContent();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final authPrefs = serviceLocator<AuthPreferenceService>();

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        return FutureBuilder<UserModel?>(
            future: authPrefs.getUser(),
            builder: (ctx, snap) {
              return Scaffold(
                backgroundColor: colorScheme.surface,
                body: CustomScrollView(
                  slivers: [
                    CartAppBar(
                      location: snap.data!.location!,
                    ),
                    if (cartState.items.isEmpty)
                      const CartEmptyState()
                    else
                      CartContent(cartState: cartState),
                  ],
                ),
                bottomSheet: cartState.items.isNotEmpty
                    ? CartCheckoutBar(cartState: cartState)
                    : SizedBox.shrink(),
              );
            });
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;

  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                error,
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
