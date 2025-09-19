// Package imports:
import 'package:formz/formz.dart';

// Project imports:
import 'package:customer_app/constants/otp_constant.dart';

/// OTP validation errors for verification screen form validation
enum OtpValidationError {
  /// OTP field is empty
  empty,

  /// OTP is incomplete (less than 4 digits)
  incomplete,

  /// OTP contains invalid characters
  invalid,
}

/// OTP verification FormzInput for optimized performance
///
/// This class provides:
/// - Type-safe validation with compile-time error checking
/// - OTP screen specific validation logic (4-digit)
/// - Industry standard FormZ pattern for UI validation
///
/// Used for real-time OTP validation without BLoC round-trips
class OtpInput extends FormzInput<String, OtpValidationError> {
  /// Creates a pure (unmodified) OTP input
  const OtpInput.pure() : super.pure('');

  /// Creates a dirty (user-modified) OTP input with validation
  const OtpInput.dirty([super.value = '']) : super.dirty();

  @override
  OtpValidationError? validator(String value) {
    if (value.isEmpty) {
      return OtpValidationError.empty;
    }

    if (value.length < OtpConstants.defaultOtpLength) {
      return OtpValidationError.incomplete;
    }

    // Validate only digits
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return OtpValidationError.invalid;
    }

    // All validation passed
    return null;
  }
}
