// theme_bloc.dart
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/core/services/theme_preference_service.dart';
import 'package:customer_app/core/themes/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> with WidgetsBindingObserver {
  final ThemePreferenceService _themePreferenceService;
  bool _isAutoTheme = true;

  ThemeBloc(this._themePreferenceService, AppTheme initialTheme)
      : super(ThemeState(
          theme: AppThemes.appThemeData[initialTheme]!,
          isAutoTheme: true,
        )) {
    
    // Register event handlers
    on<InitializeTheme>(_handleInitializeTheme);
    on<ThemeToggled>(_handleThemeToggle);
    on<SystemThemeChanged>(_handleSystemThemeChange);
    on<AutoThemeToggled>(_handleAutoThemeToggle);
    
    // Add this bloc as an observer to listen for system theme changes
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize theme settings
    add(const InitializeTheme());
  }

  // This method is called when system brightness changes
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (_isAutoTheme) {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      add(SystemThemeChanged(brightness));
    }
  }

  void _handleInitializeTheme(InitializeTheme event, Emitter<ThemeState> emit) async {
    _isAutoTheme = await _themePreferenceService.isAutoThemeEnabled();
    final currentTheme = await _themePreferenceService.getSelectedTheme();
    
    emit(state.copyWith(
      theme: AppThemes.appThemeData[currentTheme]!,
      isAutoTheme: _isAutoTheme,
    ));
  }

  void _handleThemeToggle(ThemeToggled event, Emitter<ThemeState> emit) async {
    final isLightTheme = state.theme == AppThemes.appThemeData[AppTheme.lightTheme];
    final newThemeKey = isLightTheme ? AppTheme.darkTheme : AppTheme.lightTheme;

    _isAutoTheme = false;
    await _themePreferenceService.setAutoTheme(false);
    await _themePreferenceService.setSelectedTheme(newThemeKey);
    
    emit(state.copyWith(
      theme: AppThemes.appThemeData[newThemeKey]!,
      isAutoTheme: false,
    ));
  }

  void _handleSystemThemeChange(SystemThemeChanged event, Emitter<ThemeState> emit) async {
    if (!_isAutoTheme) return;

    final newThemeKey = event.brightness == Brightness.dark 
        ? AppTheme.darkTheme 
        : AppTheme.lightTheme;

    emit(state.copyWith(
      theme: AppThemes.appThemeData[newThemeKey]!,
      isAutoTheme: true,
    ));
  }

  void _handleAutoThemeToggle(AutoThemeToggled event, Emitter<ThemeState> emit) async {
    _isAutoTheme = !_isAutoTheme;
    await _themePreferenceService.setAutoTheme(_isAutoTheme);

    if (_isAutoTheme) {
      // Switch to system theme
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final systemTheme = brightness == Brightness.dark 
          ? AppTheme.darkTheme 
          : AppTheme.lightTheme;
      
      emit(state.copyWith(
        theme: AppThemes.appThemeData[systemTheme]!,
        isAutoTheme: true,
      ));
    } else {
      // Keep current theme but disable auto
      emit(state.copyWith(isAutoTheme: false));
    }
  }

  @override
  Future<void> close() {
    // Remove observer when bloc is disposed
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
