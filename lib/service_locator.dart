// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/features/auth/data/datasources/location_remote_data_source.dart';
import 'package:customer_app/features/auth/data/repositories/location_repositories_impl.dart';
import 'package:customer_app/features/auth/domain/repositories/location_repository.dart';
import 'package:customer_app/features/auth/domain/usecases/location_usercase.dart';
import 'package:customer_app/features/auth/presentation/bloc/location/location_bloc.dart';
import 'package:customer_app/features/home/data/repositories/shop_repo_impl.dart';
import 'package:customer_app/features/home/presentation/bloc/shop/shop_bloc.dart';
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

// Category imports:
import 'package:customer_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:customer_app/features/home/data/datasources/category_remote_data_source.dart';
import 'package:customer_app/features/home/data/repositories/category_repo_impl.dart';
import 'package:customer_app/features/home/domain/repositories/category_repository.dart';
import 'package:customer_app/features/home/domain/usecase/category_usecase.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';

// Shop imports:
import 'package:customer_app/features/home/data/datasources/shop_remote_data_source.dart';
import 'package:customer_app/features/home/domain/repositories/shop_repository.dart';
import 'package:customer_app/features/home/domain/usecase/shop_usecase.dart';

// Search imports:
import 'package:customer_app/features/home/data/datasources/search_remote_data_source.dart';
import 'package:customer_app/features/home/data/repositories/search_repo_impl.dart';
import 'package:customer_app/features/home/domain/repositories/search_repository.dart';
import 'package:customer_app/features/home/domain/usecase/search_usecase.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initServiceLocator() async {
  // Theme handling
  _registerTheme();

  // Localization handling
  _registerLocalization();

  _registerLocationFeatures();

  // Connectivity handling
  _registerConnectivity();

  // Auth Features
  _registerAuthFeatures();

  // Category Features
  _registerCategoryFeatures();

  // Shop Features
  _registerShopFeatures();

  // Search Features
  _registerSearchFeatures();

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

void _registerLocationFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => LocationSearchBloc(
      searchLocationUseCase: serviceLocator<SearchLocationUseCase>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => SearchLocationUseCase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(),
  );
}

void _registerAuthFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      // register: serviceLocator<RegisterUseCase>(),
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

void _registerCategoryFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => CategoryBloc(
      getCategories: serviceLocator<GetCategoriesUseCase>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => GetCategoriesUseCase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(),
  );
}

void _registerShopFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => ShopBloc(
      getShopsByLocation: serviceLocator<GetShopsByLocationUseCase>(),
      getAutocompleteResults: serviceLocator<GetAutocompleteResultsUseCase>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => GetShopsByLocationUseCase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(),
  );
}

void _registerSearchFeatures() {
  // Use Cases
  serviceLocator.registerLazySingleton(
    () => GetAutocompleteResultsUseCase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(),
  );
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