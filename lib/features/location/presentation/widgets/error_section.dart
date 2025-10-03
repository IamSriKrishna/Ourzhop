
import 'package:customer_app/features/location/presentation/widgets/error_display_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';

class ErrorSection extends StatelessWidget {
  const ErrorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        if (state is LocationSelectionError) {
          return ErrorDisplayCard(message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}