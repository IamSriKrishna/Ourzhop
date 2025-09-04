# Code Style and Conventions

## Language & Framework
- **Dart**: Version >=3.6.0 <4.0.0
- **Flutter**: Latest stable channel
- **Linting**: Uses `package:flutter_lints/flutter.yaml`

## Architecture Patterns

### Clean Architecture
- **Data Layer**: Models, data sources, repository implementations
- **Domain Layer**: Entities, repository interfaces, use cases
- **Presentation Layer**: BLoC, screens, widgets

### BLoC Pattern
- State management using `flutter_bloc` (9.1.1)
- Separate files for events, states, and bloc logic
- Use Freezed for events and states when appropriate

### Dependency Injection
- Service Locator pattern using `get_it` (8.2.0)
- All dependencies registered in `service_locator.dart`
- Lazy singletons for services, factories for BLoCs

## Naming Conventions

### Files and Directories
- **Snake case**: `user_model.dart`, `auth_repository.dart`
- **Directory structure**: Follow Clean Architecture layers
- **Generated files**: `.g.dart` for JSON serialization, `.freezed.dart` for Freezed

### Classes and Variables
- **PascalCase**: Classes, enums (`UserEntity`, `AuthState`)
- **camelCase**: Variables, methods (`userName`, `getUserData()`)
- **SCREAMING_SNAKE_CASE**: Constants (`API_BASE_URL`)

### BLoC Naming
- **Events**: `AuthEvent`, `LoginButtonPressed`
- **States**: `AuthState`, `AuthLoading`, `AuthSuccess`
- **BLoCs**: `AuthBloc`, `ThemeBloc`

## Code Generation

### When to Run Code Generation
- After modifying JSON serializable models
- After adding/changing Freezed classes
- Use `make gen` or `make watch` for continuous generation

### Code Generation Annotations
```dart
// JSON Serialization
@JsonSerializable()
class UserModel {
  // model properties
}

// Freezed (for immutable classes)
@freezed
class AuthState with _$AuthState {
  // state definitions
}
```

## Import Organization
- Use `import_sorter` package for consistent import ordering
- Run `make format` to organize imports and format code
- External packages first, then relative imports

## Error Handling
- Use `Either` pattern for repository returns
- Custom exceptions in network layer
- Proper error states in BLoC

## Localization
- ARB files in `lib/core/l10n/`
- English: `app_en.arb`, Tamil: `app_ta.arb`
- Access via `AppLocalizations.of(context).stringKey`

## Theme Management
- Centralized theme configuration in `lib/core/themes/`
- Support for light/dark modes
- Use theme data through `Theme.of(context)`

## Testing
- Mirror lib structure in test directory
- Use `flutter_test` framework
- Run tests with coverage using `make test`

## Git Workflow
- Main branch: `dev`
- GitHub Actions for APK builds
- Manual workflow dispatch available