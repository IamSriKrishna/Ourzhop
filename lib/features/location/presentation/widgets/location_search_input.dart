
import 'package:customer_app/features/location/presentation/bloc/location_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_event.dart';

class LocationSearchInput extends StatefulWidget {
  final Function(String)? onLocationSelected;

  const LocationSearchInput({
    super.key,
    this.onLocationSelected,
  });

  @override
  State<LocationSearchInput> createState() => _LocationSearchInputState();
}

class _LocationSearchInputState extends State<LocationSearchInput> {
  final TextEditingController _controller = TextEditingController();
  late LocationSearchBloc _locationSearchBloc;

  @override
  void initState() {
    super.initState();
    _locationSearchBloc = context.read<LocationSearchBloc>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationSelectionCubit, LocationSelectionState>(
      listener: (context, state) {
        if (state is LocationSelectionCurrentLocationSet) {
          _controller.clear();
        }
      },
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search for area, street...",
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
              size: 24,
            ),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear, color: Colors.grey[500]),
                    onPressed: _clearSearch,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 18.0,
            ),
          ),
          onChanged: _onSearchChanged,
        ),
      ),
    );
  }

  void _onSearchChanged(String value) {
    context.read<LocationSelectionCubit>().clearError();

    if (value.trim().isNotEmpty && value.length >= 3) {
      _locationSearchBloc.add(SearchLocationEvent(value.trim()));
    } else {
      _locationSearchBloc.add(ClearLocationSearchEvent());
      context.read<LocationSelectionCubit>().setManualLocation(value.trim());
    }
  }

  void _clearSearch() {
    _controller.clear();
    _locationSearchBloc.add(ClearLocationSearchEvent());
    context.read<LocationSelectionCubit>().clearSelection();
  }

}
