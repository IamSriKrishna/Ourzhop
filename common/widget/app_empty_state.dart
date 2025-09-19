// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:customer_app/core/themes/app_asset.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AppAsset.emptyState),
          Text(
            message,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ],
      ),
    );
  }
}

/// Legacy widget for backward compatibility
@Deprecated('Use AppEmptyState instead')
class EmptyWidget extends AppEmptyState {
  const EmptyWidget({super.key, required super.message});
}
