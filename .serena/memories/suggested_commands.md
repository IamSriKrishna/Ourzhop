# Suggested Commands

## Essential Development Commands

### Dependencies Management
```bash
# Install dependencies
flutter pub get
make get

# Upgrade dependencies
flutter pub upgrade --major-versions
make upgrade
```

### Running the Application
```bash
# Run on all connected devices
flutter run -d all
make run

# Run on specific device
flutter run -d <device-id>
```

### Code Generation
```bash
# One-shot code generation (after modifying models/entities)
flutter pub run build_runner build --delete-conflicting-outputs
make gen

# Watch mode for continuous code generation
flutter pub run build_runner watch --delete-conflicting-outputs
make watch
```

### Code Quality & Analysis
```bash
# Static analysis
dart analyze
make analyze

# Format code and organize imports
flutter pub run import_sorter:main lib/* test/* && dart format .
make format

# Organize imports only
flutter pub run import_sorter:main lib/* test/*
make sort
```

### Testing
```bash
# Run tests with coverage
flutter test --coverage
make test
```

### Building
```bash
# Build release APK
flutter build apk --release --build-number=$(date +%s)
make apk

# Build iOS IPA (no codesign)
flutter build ipa --release --no-codesign
make ios
```

### Project Cleanup
```bash
# Clean project
flutter clean
make clean

# Remove pub cache (re-run 'make get' after)
dart pub cache clean
make cache-clean

# Clear IDE analysis cache
rm -rf ~/.dartServer/.analysis-driver/*
make analysis-cache-clear

# Full cleanup
make clean-all
```

## Darwin/macOS Specific Commands
```bash
# List files/directories
ls -la

# Change directory
cd <path>

# Find files
find . -name "*.dart" -type f

# Search in files (use ripgrep if available)
rg "pattern" --type dart
grep -r "pattern" lib/

# Git operations
git status
git add .
git commit -m "message"
git push
```

## Makefile Shortcuts Summary
- `make get` - Install dependencies
- `make run` - Run on all devices  
- `make gen` - One-shot code generation
- `make watch` - Code generation in watch mode
- `make analyze` - Static analysis
- `make format` - Format and organize imports
- `make test` - Run tests with coverage
- `make clean` - Clean build artifacts
- `make apk` - Build release APK
- `make ios` - Build iOS IPA
- `make clean-all` - Full project cleanup