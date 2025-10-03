
import 'package:flutter/material.dart';

class LocationCardContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final bool isSelected;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const LocationCardContainer({
    super.key,
    required this.child,
    required this.borderColor,
    this.isSelected = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12.0),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}