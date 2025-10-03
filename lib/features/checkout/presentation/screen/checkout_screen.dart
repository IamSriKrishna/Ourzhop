import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:customer_app/features/checkout/presentation/widgets/card_details_section.dart';
import 'package:customer_app/features/checkout/presentation/widgets/checkout_button.dart';
import 'package:customer_app/features/checkout/presentation/widgets/payment_method_card.dart';
import 'package:customer_app/features/checkout/presentation/widgets/upi_payment_section.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_state.dart';
import 'package:customer_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authPrefs = serviceLocator<AuthPreferenceService>();
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<UserModel?>(
      future: authPrefs.getUser(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: colorScheme.surface,
            body: Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
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

        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return Scaffold(
              backgroundColor: colorScheme.surface,
              body: CustomScrollView(
                slivers: [
                  CartAppBar(
                    title: 'Checkout',
                    location: snap.data?.location ?? 'Chennai, India',
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        PaymentMethodCard(colorScheme: colorScheme),
                        const SizedBox(height: 24),
                        CardDetailsSection(colorScheme: colorScheme),
                        const SizedBox(height: 24),
                        UpiPaymentSection(colorScheme: colorScheme),
                        const SizedBox(height: 100),
                      ]),
                    ),
                  ),
                ],
              ),
              bottomSheet: cartState.items.isNotEmpty
                  ? CheckoutButton(cartState: cartState)
                  : SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
