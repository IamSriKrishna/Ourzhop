// Updated main.dart with automatic theme switching
import 'package:customer_app/core/utils/auto_theme_listener.dart';
import 'package:customer_app/features/home/presentation/cubit/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:customer_app/common/widget/app_connectivity_listener.dart';
import 'package:customer_app/constants/app_language_constants.dart';
import 'package:customer_app/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:customer_app/core/bloc/localization/localization_bloc.dart';
import 'package:customer_app/core/bloc/theme/theme_bloc.dart';
import 'package:customer_app/core/l10n/app_localizations.dart';
import 'package:customer_app/core/routes/app_router.dart';
import 'package:customer_app/core/services/language_preference_service.dart';
import 'package:customer_app/core/services/theme_preference_service.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:customer_app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  await initServiceLocator();
  await Hive.initFlutter();
  await initializeLanguageSettings();
  await initializeThemeSettings();
}

Future<void> initializeLanguageSettings() async {
  final languagePreferenceService = serviceLocator<LanguagePreferenceService>();
  final storedLanguageCode =
      await languagePreferenceService.getSelectedLanguage();

  serviceLocator.registerFactory<LocalizationBloc>(
    () =>
        LocalizationBloc(languagePreferenceService, Locale(storedLanguageCode)),
  );
}

Future<void> initializeThemeSettings() async {
  final themePreferenceService = serviceLocator<ThemePreferenceService>();

  await themePreferenceService.setAutoTheme(true);

  final storedTheme = await themePreferenceService.getSelectedTheme();
  serviceLocator.registerFactory<ThemeBloc>(
    () => ThemeBloc(themePreferenceService, storedTheme),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<ThemeBloc>()),
        BlocProvider(create: (_) => serviceLocator<LocalizationBloc>()),
        BlocProvider(create: (_) => serviceLocator<ConnectivityBloc>()),
        BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
        //cart
        BlocProvider(
          create: (context) => CartCubit(),
        )
      ],
      child: AutoThemeListener(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: LanguageConstants.languages.keys
                  .map((langCode) => Locale(langCode))
                  .toList(),
              debugShowCheckedModeBanner: false,
              locale: context.watch<LocalizationBloc>().state,
              theme: themeState.theme,
              builder: (context, child) => Scaffold(
                body: AppConnectivityListener(
                  child: child ?? const SizedBox.shrink(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
