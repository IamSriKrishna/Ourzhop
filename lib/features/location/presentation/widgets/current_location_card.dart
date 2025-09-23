import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';

class CurrentLocationCard extends StatelessWidget {
  const CurrentLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return BlocBuilder<LocationSelectionCubit, LocationSelectionState>(
      builder: (context, state) {
        final cubit = context.read<LocationSelectionCubit>();
        final hasCurrentLocation = cubit.currentLocation != null;

        return GestureDetector(
          onTap: () => cubit.getCurrentLocation(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: hasCurrentLocation
                    ? appColors.primary.withOpacity(0.3)
                    : Colors.grey[200]!,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: appColors.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.currentLocation ?? "Use current location",
                        style: AppTypography.getBodyText(context).copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        hasCurrentLocation
                            ? "Location detected"
                            : "Need to give location permission",
                        style: AppTypography.getBodyText(context).copyWith(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasCurrentLocation)
                  Icon(
                    Icons.check_circle,
                    color: appColors.primary,
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
