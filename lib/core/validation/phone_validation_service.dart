import 'package:customer_app/core/models/phone_number.dart';
import 'package:customer_app/core/models/validation_result.dart';
import 'package:customer_app/core/validation/phone_validation_rulde.dart';

class PhoneValidationService {
  static final Map<String, PhoneValidationRule> _validationRules = {
    '+91': PhoneValidationRule(
      exactLength: 10,
      pattern: RegExp(r'^[6-9][0-9]{9}$'),
      errorMessage: 'Please enter a valid 10-digit mobile number',
    ),
    '+1': PhoneValidationRule(
      exactLength: 10,
      pattern: RegExp(r'^[2-9][0-9]{9}$'),
      errorMessage: 'Please enter a valid 10-digit phone number',
    ),
    '+44': PhoneValidationRule(
      minLength: 10,
      maxLength: 11,
      pattern: RegExp(r'^[1-9][0-9]{9,10}$'),
      errorMessage: 'Please enter a valid UK phone number',
    ),
  };

  static ValidationResult validatePhoneNumber(PhoneNumber phoneNumber) {
    if (phoneNumber.number.isEmpty) {
      return const ValidationResult.invalid('Phone number is required');
    }

    final rule = _validationRules[phoneNumber.countryCode];
    if (rule != null) {
      return rule.validate(phoneNumber.number);
    }

    return _validateGenericPhoneNumber(phoneNumber.number);
  }

  static ValidationResult _validateGenericPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.length < 7 || cleanNumber.length > 15) {
      return const ValidationResult.invalid(
          'Please enter a valid phone number');
    }

    if (!RegExp(r'^[0-9]{7,15}$').hasMatch(cleanNumber)) {
      return const ValidationResult.invalid(
          'Please enter a valid phone number');
    }

    return const ValidationResult.valid();
  }

  static PhoneNumber parsePhoneNumber(String fullNumber,
      {String defaultCountryCode = '+91'}) {
    if (fullNumber.isEmpty) {
      return PhoneNumber(countryCode: defaultCountryCode, number: '');
    }

    final countryCodeMatch = RegExp(r'^\+\d{1,4}').firstMatch(fullNumber);

    if (countryCodeMatch != null) {
      final countryCode = countryCodeMatch.group(0)!;
      final phoneNumber = fullNumber.substring(countryCodeMatch.end).trim();
      return PhoneNumber(countryCode: countryCode, number: phoneNumber);
    }

    return PhoneNumber(
      countryCode: defaultCountryCode,
      number: fullNumber.trim(),
    );
  }
}
