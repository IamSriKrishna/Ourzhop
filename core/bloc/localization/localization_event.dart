// Dart imports:
import 'dart:ui';

// localization_event.dart
abstract class LocalizationEvent {}

class LoadStoredLanguageEvent extends LocalizationEvent {}

class ChangeLanguageEvent extends LocalizationEvent {
  final Locale newLocale;
  ChangeLanguageEvent(this.newLocale);
}
