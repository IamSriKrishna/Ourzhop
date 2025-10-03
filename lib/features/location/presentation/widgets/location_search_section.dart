
import 'package:customer_app/features/location/presentation/widgets/location_search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:customer_app/features/location/presentation/widgets/location_search_input.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_event.dart';

class LocationSearchSection extends StatelessWidget {
  const LocationSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationSearchInput(
          onLocationSelected: (location) {
            context.read<LocationSearchBloc>().add(ClearLocationSearchEvent());
          },
        ),
        LocationSearchResults(
          onLocationSelected: (location) {
            context
                .read<LocationSelectionCubit>()
                .setSelectedSearchLocation(location.description);
            context.read<LocationSearchBloc>().add(ClearLocationSearchEvent());
          },
        ),
      ],
    );
  }
}
