import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buttonSize = size ?? screenSize.height * 0.05;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: buttonSize,
        width: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? Colors.white,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: buttonSize * 0.5,
        ),
      ),
    );
  }
}
