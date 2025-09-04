// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/core/services/language_preference_service.dart';
import 'package:customer_app/core/services/theme_preference_service.dart';
import 'package:customer_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:customer_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:customer_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:customer_app/features/auth/domain/usecases/account_setup_usecase.dart';
import 'package:customer_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:customer_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/domain/usecases/otp_verify_usecase.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  // Theme handling
  _registerTheme();

  // Localization handling
  _registerLocalization();

  // Connectivity handling
  _registerConnectivity();

  // Auth Features
  _registerAuthFeatures();

  // Error handling
  // _registerErrorHandler();

  // Network Services
  _registerNetworkServices();
}

void _registerTheme() {
  serviceLocator.registerLazySingleton(() => ThemePreferenceService());
}

void _registerLocalization() {
  serviceLocator.registerLazySingleton(() => LanguagePreferenceService());
}

void _registerConnectivity() {
  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator
      .registerLazySingleton(() => ConnectivityBloc(serviceLocator()));
}

void _registerAuthFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      register: serviceLocator<RegisterUseCase>(),
      login: serviceLocator<LoginUseCase>(),
      otpVerify: serviceLocator<OtpVerifyUseCase>(),
      accountSetup: serviceLocator<AccountSetupUseCase>(),
      prefs: serviceLocator<AuthPreferenceService>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => OtpVerifyUseCase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => AccountSetupUseCase(serviceLocator()));
  // Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  // Preference Service
  serviceLocator.registerLazySingleton(() => AuthPreferenceService());
}

// void _registerErrorHandler() {
//   serviceLocator.registerLazySingleton(() => ErrorBloc());
// }

void _registerNetworkServices() {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<DioClient>(
    () => DioClient(serviceLocator<Dio>()),
  );
}
