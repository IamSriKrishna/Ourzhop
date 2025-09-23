import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        final canContinue = context.read<LocationSelectionCubit>().canContinue;

        return Container(
          width: double.infinity,
          height: 58.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: canContinue
                ? LinearGradient(
                    colors: [
                      appColors.primary,
                      appColors.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: canContinue ? null : Colors.grey[300],
          ),
          child: ElevatedButton(
            onPressed: canContinue ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 0,
            ),
            child: Text(
              "Continue",
              style: AppTypography.getButtonText(context).copyWith(
                color: canContinue ? Colors.white : Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
