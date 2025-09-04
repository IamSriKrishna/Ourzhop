// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/core/services/theme_preference_service.dart';
import 'package:customer_app/core/themes/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemePreferenceService _themePreferenceService;

  ThemeBloc(this._themePreferenceService, AppTheme initialTheme)
      : super(ThemeState(theme: AppThemes.appThemeData[initialTheme]!)) {
    on<ThemeEvent>(_handleThemeChange);
  }

  void _handleThemeChange(ThemeEvent event, Emitter<ThemeState> emit) {
    final isLightTheme =
        state.theme == AppThemes.appThemeData[AppTheme.lightTheme];
    final newThemeKey = isLightTheme ? AppTheme.darkTheme : AppTheme.lightTheme;

    _themePreferenceService.setSelectedTheme(newThemeKey);
    emit(ThemeState(theme: AppThemes.appThemeData[newThemeKey]!));
  }
}
