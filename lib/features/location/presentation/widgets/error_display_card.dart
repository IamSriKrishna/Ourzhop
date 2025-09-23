

import 'package:flutter/material.dart';
import 'package:customer_app/core/themes/app_style.dart';

class ErrorDisplayCard extends StatelessWidget {
  final String message;

  const ErrorDisplayCard({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[600],
            size: 20,
          ),
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
}
