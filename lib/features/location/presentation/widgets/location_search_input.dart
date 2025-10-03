
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_event.dart';
import 'package:customer_app/features/location/presentation/widgets/search_text_field.dart';

class LocationSearchInput extends StatefulWidget {
  final Function(String)? onLocationSelected;
  final String hintText;
  final int minSearchLength;

  const LocationSearchInput({
    super.key,
    this.onLocationSelected,
    this.hintText = "Search for area, street...",
    this.minSearchLength = 3,
  });

  @override
  State<LocationSearchInput> createState() => LocationSearchInputState();
}

class LocationSearchInputState extends State<LocationSearchInput> {
  final TextEditingController controller = TextEditingController();
  late LocationSearchBloc locationSearchBloc;

  @override
  void initState() {
    super.initState();
    locationSearchBloc = context.read<LocationSearchBloc>();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationSelectionCubit, LocationSelectionState>(
      listener: (context, state) {
        if (state is LocationSelectionCurrentLocationSet) {
          controller.clear();
        }
      },
      child: SearchTextField(
        controller: controller,
        hintText: widget.hintText,
        onChanged: onSearchChanged,
        onClear: clearSearch,
      ),
    );
  }

  void onSearchChanged(String value) {
    context.read<LocationSelectionCubit>().clearError();

    if (value.trim().isNotEmpty && value.length >= widget.minSearchLength) {
      locationSearchBloc.add(SearchLocationEvent(value.trim()));
    } else {
      locationSearchBloc.add(ClearLocationSearchEvent());
      context.read<LocationSelectionCubit>().setManualLocation(value.trim());
    }
  }

  void clearSearch() {
    controller.clear();
    locationSearchBloc.add(ClearLocationSearchEvent());
    context.read<LocationSelectionCubit>().clearSelection();
  }
}
