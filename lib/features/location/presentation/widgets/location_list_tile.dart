import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/location/data/model/location_model.dart';

class LocationListTile extends StatelessWidget {
  final LocationModel location;
  final VoidCallback onTap;
  final IconData leadingIcon;
  final Color? leadingIconColor;
  final double? leadingIconSize;

  const LocationListTile({
    super.key,
    required this.location,
    required this.onTap,
    this.leadingIcon = Icons.location_on,
    this.leadingIconColor = Colors.grey,
    this.leadingIconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: leadingIconColor,
        size: leadingIconSize,
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
      onTap: onTap,
    );
  }
}
