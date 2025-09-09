import 'package:customer_app/features/home/widgets/search_screen_widget.dart';
import 'package:flutter/material.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          SearchScreenWidgets.searchHeader(context),
          SearchScreenWidgets.searchResults(context),
        ],
      ),
    );
  }
}