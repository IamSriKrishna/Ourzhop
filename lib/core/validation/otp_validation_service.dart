import 'package:customer_app/core/models/validation_result.dart';


class OtpValidationService {
  static const int _defaultOtpLength = 4;
  static const int _maxOtpLength = 6;

  static ValidationResult validateOtp(
    String otp, {
    int requiredLength = _defaultOtpLength,
    bool allowAllZeros = true,
  }) {
    if (otp.isEmpty) {
      return const ValidationResult.invalid('OTP is required');
    }

    final cleanOtp = otp.replaceAll(RegExp(r'\D'), '');

    if (cleanOtp.length != requiredLength) {
      return ValidationResult.invalid(
        'Please enter a valid $requiredLength-digit OTP',
      );
    }

    if (cleanOtp.length > _maxOtpLength) {
      return const ValidationResult.invalid('OTP is too long');
    }

    if (!RegExp(r'^\d+$').hasMatch(cleanOtp)) {
      return const ValidationResult.invalid('OTP must contain only numbers');
    }

    if (!allowAllZeros && cleanOtp == '0' * requiredLength) {
      return const ValidationResult.invalid('Please enter a valid OTP');
    }

    return const ValidationResult.valid();
  }

  static bool isValidOtpLength(String otp, int requiredLength) {
    return otp.replaceAll(RegExp(r'\D'), '').length == requiredLength;
  }
}
