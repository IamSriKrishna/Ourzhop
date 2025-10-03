
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_state.dart';
import 'package:customer_app/features/location/presentation/widgets/search_loading_indicator.dart';
import 'package:customer_app/features/location/presentation/widgets/search_results_list.dart';
import 'package:customer_app/features/location/presentation/widgets/search_error_message.dart';
import 'package:customer_app/features/location/presentation/widgets/search_empty_message.dart';

class LocationSearchResults extends StatelessWidget {
  final Function(LocationModel) onLocationSelected;
  final double maxHeight;

  const LocationSearchResults({
    super.key,
    required this.onLocationSelected,
    this.maxHeight = 200,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationSearchBloc, LocationSearchState>(
      builder: (context, state) {
        if (state is LocationSearchLoading) {
          return const SearchLoadingIndicator();
        } else if (state is LocationSearchSuccess) {
          return SearchResultsList(
            locations: state.locations,
            maxHeight: maxHeight,
            onLocationSelected: onLocationSelected,
          );
        } else if (state is LocationSearchError) {
          return SearchErrorMessage(message: state.message);
        } else if (state is LocationSearchEmpty) {
          return const SearchEmptyMessage();
        }

        return const SizedBox.shrink();
      },
    );
  }
}
