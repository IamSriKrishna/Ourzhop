// Package imports:

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:customer_app/constants/app_language_constants.dart';

class LanguagePreferenceService {
  static const _boxName = 'languagePreferences';
  static const _key = 'selectedLanguage';

  Future<String> getSelectedLanguage() async {
    var box = await Hive.openBox(_boxName);
    return box.get(_key, defaultValue: LanguageConstants.defaultLanguage);
  }

  Future<void> setSelectedLanguage(String languageCode) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_key, languageCode);
  }
}
