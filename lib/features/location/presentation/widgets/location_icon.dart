
import 'package:flutter/material.dart';

class LocationIcon extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final double containerSize;
  final BorderRadius? borderRadius;

  const LocationIcon({
    super.key,
    required this.backgroundColor,
    this.icon = Icons.my_location,
    this.iconColor = Colors.white,
    this.iconSize = 20,
    this.containerSize = 40.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}