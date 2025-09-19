// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:customer_app/common/network/client/dio_client.dart';
import 'package:customer_app/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:customer_app/core/services/language_preference_service.dart';
import 'package:customer_app/core/services/theme_preference_service.dart';
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/features/account_setup/data/datasources/account_setup_remote_data_source.dart';
import 'package:customer_app/features/account_setup/data/repositories/account_setup_repository_impl.dart';
import 'package:customer_app/features/account_setup/domain/repositories/account_setup_repository.dart';
import 'package:customer_app/features/account_setup/domain/usecases/account_setup_usecase.dart';
import 'package:customer_app/features/account_setup/presentation/bloc/account_setup_bloc.dart';
import 'package:customer_app/features/category/data/datasources/category_remote_data_source.dart';
import 'package:customer_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:customer_app/features/category/domain/repositories/category_repository.dart';
import 'package:customer_app/features/category/domain/usecases/category_usecase.dart';
import 'package:customer_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:customer_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:customer_app/features/login/data/datasources/login_remote_data_source.dart';
import 'package:customer_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:customer_app/features/login/domain/repositories/login_repository.dart';
import 'package:customer_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:customer_app/features/otp/data/datasources/otp_remote_data_source.dart';
import 'package:customer_app/features/otp/data/repositories/otp_repository_impl.dart';
import 'package:customer_app/features/otp/domain/repositories/otp_repository.dart';
import 'package:customer_app/features/otp/domain/usecases/otp_usecase.dart';
import 'package:customer_app/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:customer_app/features/set_location/data/datasources/set_location_remote_data_source.dart';
import 'package:customer_app/features/set_location/data/repositories/set_location_repository_impl.dart';
import 'package:customer_app/features/set_location/domain/repositories/set_location_repository.dart';
import 'package:customer_app/features/set_location/domain/usecases/set_location_usecase.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_bloc.dart';

import 'package:customer_app/features/login/domain/usecases/login_usecase.dart'
    as login_feature;

// OTP Feature imports

// Account Setup Feature imports

// Set Location Feature imports

// Category imports:

// Shop imports:
import 'package:customer_app/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:customer_app/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:customer_app/features/shop/domain/repositories/shop_repository.dart';
import 'package:customer_app/features/shop/domain/usecases/get_shops_by_location_usecase.dart';

// Search imports:

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

  // Login Features (Independent)
  _registerLoginFeatures();

  // OTP Features (Independent)
  _registerOtpFeatures();

  // Account Setup Features (Independent)
  _registerAccountSetupFeatures();

  // Category Features (Independent)
  _registerCategoryFeatures();

  // Shop Features (Independent)
  _registerShopFeatures();

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
    () => SetLocationBloc(
      setLocationUseCase: serviceLocator<SetLocationUseCase>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => SetLocationUseCase(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<SetLocationRepository>(
    () => SetLocationRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<SetLocationRemoteDataSource>(
    () => SetLocationRemoteDataSourceImpl(),
  );
}

void _registerAuthFeatures() {
  // Only register the preference service - AuthBloc functionality moved to individual features
  // UserPreferenceService is essential for:
  // - Router authentication flow control
  // - Network layer token injection
  // - Cross-feature user state management
  serviceLocator.registerLazySingleton(() => UserPreferenceService());
}

void _registerLoginFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => LoginBloc(
      login: serviceLocator<login_feature.LoginUseCase>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => login_feature.LoginUseCase(serviceLocator<LoginRepository>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(),
  );
}

void _registerOtpFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => OtpBloc(
      otpVerify: serviceLocator<OtpUseCase>(),
      loginUseCase: serviceLocator<login_feature.LoginUseCase>(),
      prefs: serviceLocator<UserPreferenceService>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => OtpUseCase(serviceLocator<OtpRepository>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<OtpRemoteDataSource>(
    () => OtpRemoteDataSourceImpl(),
  );
}

void _registerAccountSetupFeatures() {
  // Bloc
  serviceLocator.registerFactory(
    () => AccountSetupBloc(
      accountSetup: serviceLocator<AccountSetupUseCase>(),
      prefs: serviceLocator<UserPreferenceService>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => AccountSetupUseCase(serviceLocator<AccountSetupRepository>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<AccountSetupRepository>(
    () => AccountSetupRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<AccountSetupRemoteDataSource>(
    () => AccountSetupRemoteDataSourceImpl(),
  );
}

void _registerCategoryFeatures() {
  // Home Features (Uses CategoryUseCase for integration)
  _registerHomeFeatures();
  // Bloc
  serviceLocator.registerFactory(
    () => CategoryBloc(
      getCategories: serviceLocator<GetCategoriesUseCase>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => GetCategoriesUseCase(serviceLocator<CategoryRepository>()),
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
  // Use Case
  serviceLocator.registerLazySingleton<GetShopsByLocationUseCase>(
    () => GetShopsByLocationUseCase(serviceLocator<ShopRepository>()),
  );

  // Repository
  serviceLocator.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(
      remoteDataSource: serviceLocator<ShopRemoteDataSource>(),
    ),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(),
  );
}

void _registerHomeFeatures() {
  // Bloc - Uses existing GetCategoriesUseCase for category section integration
  // and GetShopsByLocationUseCase for shop section integration
  serviceLocator.registerFactory(
    () => HomeBloc(
      getCategories: serviceLocator<GetCategoriesUseCase>(),
      getShopsByLocation: serviceLocator<GetShopsByLocationUseCase>(),
    ),
  );
}

void _registerNetworkServices() {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<DioClient>(
    () => DioClient(serviceLocator<Dio>()),
  );
}
