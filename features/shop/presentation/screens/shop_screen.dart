// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:customer_app/features/shop/presentation/bloc/shop_state.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shops'),
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          // TODO: Implement UI based on state
          return const Center(
            child: Text(
              'Shop Screen - UI Implementation Pending',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
