// localization_bloc.dart

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/core/services/language_preference_service.dart';
import 'localization_event.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, Locale> {
  final LanguagePreferenceService _languagePreferenceService;

  LocalizationBloc(this._languagePreferenceService, Locale locale)
      : super(locale) {
    // Default locale set to 'en' initially
    on<LoadStoredLanguageEvent>(_onLoadStoredLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadStoredLanguage(
      LoadStoredLanguageEvent event, Emitter<Locale> emit) async {
    final languageCode = await _languagePreferenceService.getSelectedLanguage();
    emit(Locale(languageCode));
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event, Emitter<Locale> emit) async {
    await _languagePreferenceService
        .setSelectedLanguage(event.newLocale.languageCode);
    emit(Locale(event.newLocale.languageCode));
  }
}
