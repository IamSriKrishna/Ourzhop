import 'package:customer_app/core/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoThemeListener extends StatefulWidget {
  final Widget child;

  const AutoThemeListener({super.key, required this.child});

  @override
  State<AutoThemeListener> createState() => _AutoThemeListenerState();
}

class _AutoThemeListenerState extends State<AutoThemeListener>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Trigger initial theme check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndUpdateTheme();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _checkAndUpdateTheme();
  }

  void _checkAndUpdateTheme() {
    final themeBloc = context.read<ThemeBloc>();
    final currentBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    // Always update to match system theme
    if (themeBloc.state.isAutoTheme) {
      themeBloc.add(SystemThemeChanged(currentBrightness));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
