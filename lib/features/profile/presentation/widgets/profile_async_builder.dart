
import 'package:flutter/material.dart';

class AsyncBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  const AsyncBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FutureBuilder<T>(
      future: future,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return loadingBuilder?.call(context) ??
              Scaffold(
                backgroundColor: colorScheme.surface,
                body: Center(
                  child: CircularProgressIndicator(color: colorScheme.primary),
                ),
              );
        }

        if (snap.hasError) {
          return errorBuilder?.call(context, snap.error!) ??
              Scaffold(
                backgroundColor: colorScheme.surface,
                body: Center(
                  child: Text(
                    'Error: ${snap.error}',
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              );
        }

        return builder(context, snap.data as T);
      },
    );
  }
}