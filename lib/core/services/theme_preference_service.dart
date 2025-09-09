// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:customer_app/core/themes/app_theme.dart';

class ThemePreferenceService {
  static const _boxName = 'themePreferences';
  static const _themeKey = 'selectedTheme';
  static const _autoThemeKey = 'autoTheme';

  Future<void> setSelectedTheme(AppTheme theme) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_themeKey, theme.toString().split('.').last);
  }

  Future<void> setAutoTheme(bool isAuto) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_autoThemeKey, isAuto);
  }

  Future<bool> isAutoThemeEnabled() async {
    var box = await Hive.openBox(_boxName);
    return box.get(_autoThemeKey, defaultValue: true); // Default to auto
  }

  Future<AppTheme> getSelectedTheme() async {
    var box = await Hive.openBox(_boxName);
    final bool isAuto = box.get(_autoThemeKey, defaultValue: true); // Avoid calling isAutoThemeEnabled() again

    if (isAuto) {
      // Follow system theme
      final brightness = PlatformDispatcher.instance.platformBrightness;
      return brightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;
    } else {
      // Use manually selected theme
      final String? themeStr = box.get(_themeKey);
      if (themeStr == null) {
        // If no manual theme is set, default to system theme
        final brightness = PlatformDispatcher.instance.platformBrightness;
        return brightness == Brightness.dark
            ? AppTheme.darkTheme
            : AppTheme.lightTheme;
      } else {
        return AppTheme.values.firstWhere(
          (e) => e.toString().split('.').last == themeStr,
          orElse: () => AppTheme.lightTheme,
        );
      }
    }
  }
}