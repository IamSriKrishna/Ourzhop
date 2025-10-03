import 'package:flutter/material.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';
import 'package:customer_app/features/location/presentation/widgets/location_list_tile.dart';

class SearchResultsList extends StatelessWidget {
  final List<LocationModel> locations;
  final double maxHeight;
  final Function(LocationModel) onLocationSelected;

  const SearchResultsList({
    super.key,
    required this.locations,
    required this.maxHeight,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      constraints: BoxConstraints(maxHeight: maxHeight),
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
          return LocationListTile(
            location: locations[index],
            onTap: () => onLocationSelected(locations[index]),
          );
        },
      ),
    );
  }
}
