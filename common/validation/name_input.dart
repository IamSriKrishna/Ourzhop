// Package imports:
import 'package:formz/formz.dart';

/// Name validation errors for account setup form validation
enum NameValidationError {
  /// Name field is empty
  empty,

  /// Name is too short (less than 2 characters)
  tooShort,

  /// Name is too long (more than 50 characters)
  tooLong,

  /// Name contains invalid characters
  invalid,
}

/// Account setup name FormzInput for optimized performance
///
/// This class provides:
/// - Type-safe validation with compile-time error checking
/// - Account setup specific validation logic
/// - Industry standard FormZ pattern for UI validation
///
/// Used for real-time name validation without BLoC round-trips
class AccountSetupName extends FormzInput<String, NameValidationError> {
  /// Creates a pure (unmodified) name input
  const AccountSetupName.pure() : super.pure('');

  /// Creates a dirty (user-modified) name input with validation
  const AccountSetupName.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return NameValidationError.empty;
    }

    if (trimmedValue.length < 2) {
      return NameValidationError.tooShort;
    }

    if (trimmedValue.length > 50) {
      return NameValidationError.tooLong;
    }

    // Validate only letters, spaces, and some special characters
    if (!RegExp(r"^[a-zA-Z\s\.\-']+$").hasMatch(trimmedValue)) {
      return NameValidationError.invalid;
    }

    // All validation passed
    return null;
  }
}
