import 'package:flutter/material.dart';
import 'package:customer_app/features/location/presentation/widgets/message_card.dart';

class SearchEmptyMessage extends StatelessWidget {
  final String message;

  const SearchEmptyMessage({
    super.key,
    this.message = "No locations found for your search",
  });

  @override
  Widget build(BuildContext context) {
    return MessageCard(
      message: message,
      icon: Icons.location_off,
      iconColor: Colors.grey[500]!,
      backgroundColor: Colors.grey[50]!,
      borderColor: Colors.grey[200]!,
      textColor: Colors.grey[600]!,
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
    );
  }
}
