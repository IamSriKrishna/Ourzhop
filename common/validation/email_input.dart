// Package imports:
import 'package:formz/formz.dart';

/// Email validation errors for account setup form validation
enum EmailValidationError {
  /// Email field is empty
  empty,

  /// Email format is invalid
  invalid,

  /// Email is too long (more than 254 characters - RFC 5321 limit)
  tooLong,
}

/// Account setup email FormzInput for optimized performance
///
/// This class provides:
/// - Type-safe validation with compile-time error checking
/// - Account setup specific validation logic
/// - Industry standard FormZ pattern for UI validation
/// - RFC 5322 compliant email validation
///
/// Used for real-time email validation without BLoC round-trips
class AccountSetupEmail extends FormzInput<String, EmailValidationError> {
  /// Creates a pure (unmodified) email input
  const AccountSetupEmail.pure() : super.pure('');

  /// Creates a dirty (user-modified) email input with validation
  const AccountSetupEmail.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return EmailValidationError.empty;
    }

    if (trimmedValue.length > 254) {
      return EmailValidationError.tooLong;
    }

    // RFC 5322 compliant email validation
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");

    if (!emailRegex.hasMatch(trimmedValue)) {
      return EmailValidationError.invalid;
    }

    // All validation passed
    return null;
  }
}
