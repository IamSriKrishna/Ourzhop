
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/presentation/widgets/gradient_button.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double height;
  final double borderRadius;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.label = "Continue",
    this.height = 58.0,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        final canContinue = context.read<LocationSelectionCubit>().canContinue;

        return GradientButton(
          onPressed: canContinue ? onPressed : null,
          isEnabled: canContinue,
          label: label,
          height: height,
          borderRadius: borderRadius,
        );
      },
    );
  }
}