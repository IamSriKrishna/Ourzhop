
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/location/presentation/bloc/location/location_state.dart';

class LocationSearchResults extends StatelessWidget {
  final Function(LocationModel) onLocationSelected;

  const LocationSearchResults({
    super.key,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationSearchBloc, LocationSearchState>(
      builder: (context, state) {
        if (state is LocationSearchLoading) {
          return _buildLoadingState();
        } else if (state is LocationSearchSuccess) {
          return _buildSearchResults(context, state.locations);
        } else if (state is LocationSearchError) {
          return _buildErrorState(context, state.message);
        } else if (state is LocationSearchEmpty) {
          return _buildEmptyState(context);
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState() {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      height: 60,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, List<LocationModel> locations) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return _buildLocationTile(context, location);
        },
      ),
    );
  }

  Widget _buildLocationTile(BuildContext context, LocationModel location) {
    return ListTile(
      leading: const Icon(
        Icons.location_on,
        color: Colors.grey,
        size: 20,
      ),
      title: Text(
        location.mainText,
        style: AppTypography.getBodyText(context).copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        location.secondaryText,
        style: AppTypography.getBodyText(context).copyWith(
          color: Colors.grey[600],
          fontSize: 12,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => onLocationSelected(location),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[600], size: 20),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: AppTypography.getBodyText(context).copyWith(
                color: Colors.red[700],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.location_off, color: Colors.grey[500], size: 20),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              "No locations found for your search",
              style: AppTypography.getBodyText(context).copyWith(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}