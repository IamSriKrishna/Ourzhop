# Development Workflow

## Project Setup
1. **Clone Repository**: Clone the eshop-seller-ui project
2. **Install Dependencies**: Run `flutter pub get` or `make get`
3. **Code Generation**: Run `make gen` for initial build runner execution
4. **Verify Setup**: Run `flutter run` or `make run` to test

## Daily Development Workflow

### Starting Development
```bash
# Pull latest changes
git pull

# Install/update dependencies
make get

# Start code generation in watch mode (if working with models)
make watch  # Optional, run in separate terminal
```

### During Development
```bash
# Run app on all connected devices
make run

# Check code quality continuously
make analyze

# Format code when needed
make format
```

### Feature Development Process

#### 1. Create New Feature
- Follow Clean Architecture structure: `features/feature_name/{data,domain,presentation}`
- Implement layers in order: domain → data → presentation

#### 2. Implement Domain Layer
- Create entities in `domain/entities/`
- Define repository interfaces in `domain/repositories/`
- Implement use cases in `domain/usecases/`

#### 3. Implement Data Layer
- Create models with JSON serialization in `data/models/`
- Implement data sources in `data/datasources/`
- Create repository implementations in `data/repositories/`

#### 4. Implement Presentation Layer
- Create BLoC with events/states in `presentation/bloc/`
- Build screens in `presentation/screens/`
- Add feature-specific widgets in `presentation/widgets/`

#### 5. Register Dependencies
- Add all new dependencies to `service_locator.dart`
- Follow the pattern: data sources → repositories → use cases → BLoCs

#### 6. Add Navigation
- Update `app_router.dart` with new routes
- Add route constants if needed

### Code Generation Workflow
```bash
# When modifying models/entities
make gen

# For continuous development with models
make watch  # Runs in background, regenerates on file changes
```

### Quality Assurance
```bash
# Before committing
make analyze  # Fix any issues
make format   # Organize imports and format
make test     # Ensure tests pass
```

## Localization Workflow
1. **Add Strings**: Update ARB files in `lib/core/l10n/`
   - English: `app_en.arb`
   - Tamil: `app_ta.arb`
2. **Generate**: Run `flutter pub get` to regenerate localization files
3. **Use**: Access via `AppLocalizations.of(context).stringKey`

## Testing Workflow
```bash
# Run all tests
make test

# Run specific test file
flutter test test/path/to/test_file.dart

# Run tests with coverage report
flutter test --coverage
```

## Build and Release Workflow

### Debug Testing
```bash
# Quick debug build
flutter run

# Run on specific device
flutter run -d <device-id>
```

### Release Builds
```bash
# Android APK
make apk

# iOS IPA (no codesigning)
make ios
```

### CI/CD
- GitHub Actions available for APK builds
- Manual trigger via workflow_dispatch
- Automated builds can be configured for push to specific branches

## Troubleshooting Common Issues

### Build Issues
```bash
# Clean and rebuild
make clean
make get
make gen
```

### Cache Issues
```bash
# Clear various caches
make clean-all  # Comprehensive cleanup
```

### Code Generation Issues
```bash
# Force regeneration
make gen
# Or with watch mode
make watch
```

### Dependency Issues
```bash
# Update dependencies
make upgrade
# Or clean install
make cache-clean
make get
```