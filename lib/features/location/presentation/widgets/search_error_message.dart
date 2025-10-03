import 'package:flutter/material.dart';
import 'package:customer_app/features/location/presentation/widgets/message_card.dart';

class SearchErrorMessage extends StatelessWidget {
  final String message;

  const SearchErrorMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return MessageCard(
      message: message,
      icon: Icons.error_outline,
      iconColor: Colors.red[600]!,
      backgroundColor: Colors.red[50]!,
      borderColor: Colors.red[200]!,
      textColor: Colors.red[700]!,
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
    );
  }
}
