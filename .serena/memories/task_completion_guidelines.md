# Task Completion Guidelines

## Pre-Task Setup
1. **Code Generation**: If modifying models/entities, run `make gen` after changes
2. **Dependencies**: Ensure all dependencies are installed with `make get`
3. **Clean Build**: Consider `make clean` if encountering build issues

## During Development

### Code Quality Checks
1. **Analyze Code**: Run `dart analyze` or `make analyze` for static analysis
2. **Format Code**: Use `make format` to organize imports and format code
3. **Follow Architecture**: Maintain Clean Architecture patterns (data/domain/presentation)

### Testing
1. **Write Tests**: Add tests for new functionality
2. **Run Tests**: Execute `flutter test --coverage` or `make test`
3. **Coverage**: Ensure adequate test coverage for critical paths

## Required Actions When Task is Completed

### 1. Code Generation (If Applicable)
```bash
# If you modified any models, entities, or Freezed classes
make gen
# Or in watch mode during development
make watch
```

### 2. Code Quality Validation
```bash
# Static analysis - MUST pass
make analyze

# Format and organize imports - MUST run
make format
```

### 3. Testing
```bash
# Run all tests with coverage
make test
```

### 4. Build Verification (For Major Changes)
```bash
# Verify app builds successfully
flutter build apk --debug
# Or for quick verification
flutter run --debug
```

## Pre-Commit Checklist
- [ ] Code generation completed (if models/entities modified)
- [ ] Static analysis passes (`make analyze`)
- [ ] Code formatted and imports organized (`make format`)
- [ ] Tests pass (`make test`)
- [ ] App builds without errors
- [ ] Follows Clean Architecture patterns
- [ ] BLoC pattern implemented correctly
- [ ] Dependencies properly registered in service_locator.dart
- [ ] Localization strings added (if applicable)
- [ ] Theme integration maintained

## Common Issues to Avoid
1. **Missing Code Generation**: Always run `make gen` after model changes
2. **Import Disorganization**: Use `make format` for consistent imports
3. **Lint Violations**: Address all `dart analyze` warnings
4. **Missing Dependencies**: Register new dependencies in `service_locator.dart`
5. **Architecture Violations**: Keep layers properly separated
6. **Missing Tests**: Write tests for new functionality

## CI/CD Integration
- GitHub Actions will build APK on workflow dispatch
- Ensure local build passes before pushing changes
- Manual trigger available for APK builds

## Quick Commands Summary
```bash
# Complete task validation sequence
make gen && make analyze && make format && make test
```