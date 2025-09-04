# Codebase Structure

## Root Directory Structure
```
eshop-seller-ui/
├── lib/                    # Main source code
├── test/                   # Test files
├── android/                # Android platform specific
├── ios/                    # iOS platform specific
├── web/                    # Web platform specific
├── linux/                  # Linux platform specific
├── macos/                  # macOS platform specific
├── windows/                # Windows platform specific
├── asset/                  # Assets (images, fonts)
├── .github/workflows/      # CI/CD GitHub Actions
├── pubspec.yaml           # Dependencies and configuration
├── Makefile              # Development shortcuts
├── CLAUDE.md             # Claude AI instructions
├── README.md             # Project documentation
└── analysis_options.yaml # Dart analyzer configuration
```

## lib/ Directory Structure (Clean Architecture)
```
lib/
├── main.dart              # Application entry point
├── service_locator.dart   # Dependency injection setup
├── common/                # Shared components across features
│   ├── dialog/           # Reusable dialogs (delete, retry, progress)
│   ├── network/          # API client, error handling, result types
│   ├── repository/       # Repository helpers
│   ├── validators/       # Form validation utilities
│   ├── widget/           # Reusable UI widgets
│   └── usecase/          # Shared use case logic
├── constants/            # Application constants
│   └── app_language_constants.dart
├── core/                 # Core application functionality
│   ├── bloc/            # Core BLoCs (theme, localization, connectivity)
│   ├── l10n/            # Localization files (.arb)
│   ├── routes/          # Go Router configuration
│   ├── services/        # Preference services
│   ├── themes/          # Theme configuration
│   ├── utils/           # Utility classes
│   └── bottom_navigation/ # Bottom navigation logic
└── features/            # Feature modules
    ├── auth/            # Authentication feature
    ├── home/            # Home feature
    └── pages/           # Other pages
```

## Feature Structure (Following Clean Architecture)
Each feature follows this structure:
```
feature_name/
├── data/
│   ├── datasources/     # Remote/Local data sources
│   ├── models/         # Data models with JSON serialization (.g.dart)
│   └── repositories/   # Repository implementations
├── domain/
│   ├── entities/       # Business entities
│   ├── repositories/   # Repository interfaces (abstract)
│   └── usecases/       # Business logic/use cases
└── presentation/
    ├── bloc/          # BLoC state management
    ├── screens/       # UI screens
    └── widgets/       # Feature-specific widgets
```

## Auth Feature Example
```
auth/
├── data/
│   ├── datasources/auth_remote_data_source.dart
│   ├── models/ (user_model.dart, otp_verification_model.dart, category_model.dart)
│   └── repositories/auth_repository_impl.dart
├── domain/
│   ├── entities/ (user_entity.dart, otp_verification_entity.dart)
│   ├── repositories/auth_repository.dart
│   └── usecases/ (login_usecase.dart, otp_verify_usecase.dart, etc.)
└── presentation/
    ├── bloc/ (auth_bloc.dart, auth_event.dart, auth_state.dart)
    └── screens/ (login_screen.dart, otp_screen.dart, account_setup_screen.dart)
```

## Core Components
- **service_locator.dart**: Registers all dependencies using GetIt
- **app_router.dart**: Go Router configuration for navigation
- **Network Layer**: Centralized API client with error handling
- **Theme System**: Centralized theming with light/dark mode support
- **Localization**: ARB files for English and Tamil translations