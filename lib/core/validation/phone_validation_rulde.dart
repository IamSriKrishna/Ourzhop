import 'package:customer_app/core/models/validation_result.dart';

class PhoneValidationRule {
  final int? exactLength;
  final int? minLength;
  final int? maxLength;
  final RegExp pattern;
  final String errorMessage;

  const PhoneValidationRule({
    this.exactLength,
    this.minLength,
    this.maxLength,
    required this.pattern,
    required this.errorMessage,
  });

  ValidationResult validate(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (exactLength != null && cleanNumber.length != exactLength) {
      return ValidationResult.invalid(errorMessage);
    }

    if (minLength != null && cleanNumber.length < minLength!) {
      return ValidationResult.invalid(errorMessage);
    }

    if (maxLength != null && cleanNumber.length > maxLength!) {
      return ValidationResult.invalid(errorMessage);
    }

    if (!pattern.hasMatch(cleanNumber)) {
      return ValidationResult.invalid(errorMessage);
    }

    return const ValidationResult.valid();
  }
}
