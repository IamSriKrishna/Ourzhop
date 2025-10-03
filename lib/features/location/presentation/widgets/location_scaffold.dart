
import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/features/location/presentation/widgets/location_header.dart';
import 'package:customer_app/features/location/presentation/widgets/location_search_section.dart';
import 'package:customer_app/features/location/presentation/widgets/current_location_card.dart';
import 'package:customer_app/features/location/presentation/widgets/error_section.dart';
import 'package:customer_app/features/location/presentation/widgets/continue_button.dart';

class LocationScaffold extends StatelessWidget {
  final VoidCallback onContinue;

  const LocationScaffold({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: appColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35.0),
                const LocationHeader(),
                const SizedBox(height: 24.0),
                const LocationSearchSection(),
                const SizedBox(height: 16.0),
                const CurrentLocationCard(),
                const ErrorSection(),
                const Spacer(),
                ContinueButton(onPressed: onContinue),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
