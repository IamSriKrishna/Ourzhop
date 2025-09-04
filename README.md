# Flutter Clean Architecture with Bloc Pattern

This Flutter project implements the Clean Architecture principles combined with the BLoC (Business Logic Component) design pattern. It also incorporates localization, theming, and logging features. This README provides a detailed explanation of the project structure, data flow, and guidelines on how to add new screens (e.g., a login screen) following the same folder and design patterns.

## Table of Contents

- [Project Structure](#project-structure)
- [Data Flow](#data-flow)
- [Adding a New Screen (e.g., Login)](#adding-a-new-screen-eg-login)
- [Localization Steps](#localization-steps)
- [Theming](#theming)
- [Logging](#logging)
- [Getting Started](#getting-started)
- [Dependencies](#dependencies)

## Project Structure

The project follows a modular structure, separating concerns into different layers and features. Here's an overview of the `lib` folder:

```
lib
│   main.dart
│   service_locator.dart
│
├───common
│   ├───bloc
│   ├───dialog
│   ├───network
│   ├───repository
│   ├───usecase
│   └───widget
│
├───constants
│       app_language_constants.dart
│
├───core
│   ├───bloc
│   ├───l10n
│   ├───services
│   ├───themes
│   └───utils
│
└───features
    ├───comment
    ├───post
    ├───todo
    └───user
```

### **Main Files**

- `main.dart`: The entry point of the application.
- `service_locator.dart`: Sets up dependency injection using the `GetIt` package.

### **Common Folder**

Contains reusable components and helpers:

- **bloc**: Helper classes for BLoC implementations.
- **dialog**: Common dialog widgets like `create_dialog.dart`, `delete_dialog.dart`, etc.
- **network**: Network-related configurations and helper classes like `dio_client.dart`, `api_helper.dart`, etc.
- **repository**: Contains `repository_helper.dart` for shared repository logic.
- **usecase**: Includes `usecase_helper.dart` for shared use case logic.
- **widget**: Reusable widgets such as `date_time_picker.dart`, `app_dropdown.dart`, etc.

### **Constants Folder**

- `app_language_constants.dart`: Defines constants for app languages.

### **Core Folder**

Contains core functionalities:

- **bloc**: Core BLoCs for localization and theming.
- **l10n**: Localization files (`.arb` files).
- **services**: Services for managing language and theme preferences.
- **themes**: Theming-related files like `app_color.dart`, `app_style.dart`, etc.
- **utils**: Utility classes like `app_logger.dart`.

### **Features Folder**

Each subfolder represents a feature and follows the same structure:

```
feature_name
├── data
│   ├── datasources
│   ├── models
│   └── repositories
├── domain
│   ├── entities
│   ├── repositories
│   └── usecases
└── presentation
    ├── bloc
    ├── screens
    └── widgets
```

#### **Data Layer**

- **datasources**: Contains data source classes (e.g., remote APIs).
- **models**: Data models and JSON serialization.
- **repositories**: Implementation of repository interfaces.

#### **Domain Layer**

- **entities**: Defines core business objects.
- **repositories**: Abstract classes defining repository interfaces.
- **usecases**: Contains business logic.

#### **Presentation Layer**

- **bloc**: BLoC classes for state management.
- **screens**: UI screens.
- **widgets**: Custom widgets for the feature.

## Data Flow

The application follows the Clean Architecture's flow:

1. **Presentation Layer**: UI components interact with BLoCs.
2. **Domain Layer**: BLoCs communicate with use cases.
3. **Data Layer**: Use cases interact with repositories, which fetch or persist data through data sources.

**Flow Steps:**

- **User Interaction**: Triggers events in the UI.
- **BLoC Processing**: Captures events and maps them to states.
- **Use Case Execution**: BLoCs call use cases to perform business logic.
- **Data Fetching/Persistence**: Use cases interact with repositories.
- **Data Sources**: Repositories fetch from remote APIs or local databases.
- **State Update**: Results are passed back up to the BLoC and UI.

## Adding a New Screen (e.g., Login)

To add a new screen like a login screen, follow these steps:

### **1. Create Feature Folder**

Create a new folder under `features`:

```
features
└───auth
    ├── data
    ├── domain
    └── presentation
```

### **2. Data Layer**

#### **a. Data Sources**

Create a data source for handling API calls:

- **File**: `auth_remote_data_source.dart`

```dart
class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password) async {
    // Implement API call logic here
  }
}
```

#### **b. Models**

Define the user model:

- **File**: `user_model.dart`

```dart
class UserModel extends UserEntity {
  // Implement fields and methods
}
```

#### **c. Repositories Implementation**

Implement the repository interface:

- **File**: `auth_repository_impl.dart`

```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }
}
```

### **3. Domain Layer**

#### **a. Entities**

Define the user entity:

- **File**: `user_entity.dart`

```dart
class UserEntity {
  final String id;
  final String email;
  // Other user properties
}
```

#### **b. Repositories**

Create an abstract repository:

- **File**: `auth_repository.dart`

```dart
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
}
```

#### **c. Use Cases**

Implement the login use case:

- **File**: `login_usecase.dart`

```dart
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}
```

### **4. Presentation Layer**

#### **a. BLoC**

Implement the authentication BLoC:

- **File**: `auth_bloc.dart`

```dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginButtonPressed) {
      yield AuthLoading();
      final failureOrUser = await loginUseCase(event.email, event.password);
      yield failureOrUser.fold(
        (failure) => AuthFailure(message: failure.message),
        (user) => Authenticated(user: user),
      );
    }
  }
}
```

#### **b. Events and States**

- **File**: `auth_event.dart`

```dart
abstract class AuthEvent {}

class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}
```

- **File**: `auth_state.dart`

```dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;

  Authenticated({required this.user});
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}
```

#### **c. Screens**

Create the login screen UI:

- **File**: `login_screen.dart`

```dart
class LoginScreen extends StatelessWidget {
  // Build method with form fields and BlocConsumer<AuthBloc, AuthState>
}
```

### **5. Dependency Injection**

Register the new classes in `service_locator.dart`:

```dart
// Data sources
sl.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(),
);

// Repositories
sl.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(remoteDataSource: sl()),
);

// Use cases
sl.registerLazySingleton(() => LoginUseCase(repository: sl()));

// BLoC
sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
```

### **6. Update Routes**

Add the login screen to your routes in `main.dart` or your routing file:

```dart
onGenerateRoute: (RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginScreen());
    // Other routes
  }
}
```

### **7. Localization**

Add any new strings to your localization files in `lib/core/l10n`.

### **8. Theming**

Ensure your new screen uses the app's theming by utilizing styles from `app_style.dart` and colors from `app_color.dart`.

## Localization Steps

To add a new language:

1. **Create a New ARB File**: In the `lib/core/l10n` directory, create a new ARB file named `app_xx.arb` (e.g., `app_es.arb` for Spanish) with the translated content.

2. **Update Language Constants**: Add the new language to `lib/constants/app_language_constants.dart`:

   ```dart
   const Map<String, String> languageMap = {
     'en': 'English',
     'ta': 'தமிழ்',
     'es': 'Español',
     // Add other languages here
   };
   ```

3. **Generate Localization Files**: Run the following command to automatically generate localization files:

   ```bash
   flutter pub get
   ```

4. **Regenerate After Updates**: After updating any ARB file content, run `flutter pub get` again to regenerate the files.

## Theming

The app's theming is managed centrally to ensure consistency across all screens.

### **Theme Files**

Located in `lib/core/themes`:

- **app_color.dart**: Defines color constants.
- **app_style.dart**: Contains text styles and other common styles.
- **app_theme.dart**: Configures the overall theme data.

### **Changing Themes**

- Use the `ThemeBloc` located in `lib/core/bloc/theme` to toggle between light and dark modes.
- Dispatch `ThemeEvent` to change themes dynamically.

### **Usage in Widgets**

- Access theme data using `Theme.of(context)`.
- Use styles from `app_style.dart` and colors from `app_color.dart`.

## Logging

Logging is implemented to aid in debugging and monitoring app behavior.

### **Logger Setup**

- The `app_logger.dart` file in `lib/core/utils` contains the logging utility.
- It uses the `logger` package for structured logging.

### **Usage**

```dart
AppLogger.log('This is a debug message');
AppLogger.error('This is an error message');
```

## Getting Started

### **Prerequisites**

- Flutter SDK installed
- Dart SDK installed

### **Installation Steps**

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/yourproject.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd yourproject
   ```

3. **Install Dependencies**

   ```bash
   flutter pub get
   ```

4. **Generate Code (if necessary)**

   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

### **Running the App**

```bash
flutter run
```

## Dependencies

- **flutter_bloc**: State management using BLoC.
- **dio**: HTTP client for API calls.
- **get_it**: Dependency injection.
- **freezed**: Code generation for unions/pattern-matching.
- **json_serializable**: JSON serialization.
- **equatable**: Simplifies equality comparisons.
- **intl**: Internationalization.
- **logger**: Logging utility.

---
#   O u r z h o p  
 