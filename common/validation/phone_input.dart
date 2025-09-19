// Package imports:
import 'package:formz/formz.dart';

// Project imports:
import 'package:customer_app/constants/phone_constants.dart';

/// Phone number validation errors for login screen form validation
enum PhoneValidationError {
  /// Phone number field is empty
  empty,

  /// Phone number is too short (less than 10 digits)
  tooShort,

  /// Phone number is too long (more than 10 digits)
  tooLong,

  /// Phone number contains invalid characters
  invalid,
}

/// Login screen phone number FormzInput for optimized performance
///
/// This class provides:
/// - Type-safe validation with compile-time error checking
/// - Login screen specific validation logic
/// - Industry standard FormZ pattern for UI validation
///
/// Used for real-time phone number validation without BLoC round-trips
class LoginPhoneNumber extends FormzInput<String, PhoneValidationError> {
  /// Creates a pure (unmodified) phone number input
  const LoginPhoneNumber.pure() : super.pure('');

  /// Creates a dirty (user-modified) phone number input with validation
  const LoginPhoneNumber.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.empty;
    }

    if (value.length < PhoneConstants.exactPhoneLength) {
      return PhoneValidationError.tooShort;
    }

    if (value.length > PhoneConstants.exactPhoneLength) {
      return PhoneValidationError.tooLong;
    }

    // Validate only digits
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return PhoneValidationError.invalid;
    }

    // All validation passed
    return null;
  }
}
