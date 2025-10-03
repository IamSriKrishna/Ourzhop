
// ignore_for_file: deprecated_member_use

import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:customer_app/features/location/presentation/widgets/location_card_container.dart';
import 'package:customer_app/features/location/presentation/widgets/location_card_content.dart';
import 'package:customer_app/features/location/presentation/widgets/location_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/core/themes/app_colors.dart';
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
          child: LocationCardContainer(
            isSelected: hasCurrentLocation,
            borderColor: hasCurrentLocation
                ? appColors.primary.withOpacity(0.3)
                : Colors.grey[200]!,
            child: Row(
              children: [
                LocationIcon(backgroundColor: appColors.primary),
                const SizedBox(width: 16.0),
                Expanded(
                  child: LocationCardContent(
                    title: cubit.currentLocation ?? "Use current location",
                    subtitle: hasCurrentLocation
                        ? "Location detected"
                        : "Need to give location permission",
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