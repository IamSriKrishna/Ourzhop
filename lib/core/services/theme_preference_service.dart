// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:customer_app/core/themes/app_theme.dart';

class ThemePreferenceService {
  static const _boxName = 'themePreferences';
  static const _key = 'selectedTheme';

  Future<void> setSelectedTheme(AppTheme theme) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_key, theme.toString().split('.').last);
  }

  Future<AppTheme> getSelectedTheme() async {
    var box = await Hive.openBox(_boxName);//use _boxName
    final String? themeStr = box.get(_key); // No defaultValue here

    if (themeStr == null) {
      // Detect the device brightness if no theme is stored yet
      final brightness = PlatformDispatcher.instance.platformBrightness;
      final deviceTheme = brightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;

      // Store the device theme for future use
      await setSelectedTheme(deviceTheme);
      return deviceTheme;
    } else {
      // Parse the stored theme string back into an AppTheme
      return AppTheme.values.firstWhere(
        (e) => e.toString().split('.').last == themeStr,
        orElse: () => AppTheme.darkTheme,
      );
    }
  }
}
