
import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_style.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final double fontSize;

  const MessageCard({
    super.key,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.margin,
    required this.padding,
    this.iconSize = 20,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: AppTypography.getBodyText(context).copyWith(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}