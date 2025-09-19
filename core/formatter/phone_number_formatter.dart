// Flutter imports:
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  static const int _spacePosition = 5;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final formatted = _formatPhoneNumber(text);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= _spacePosition) {
      return phoneNumber;
    }

    final buffer = StringBuffer();
    for (int i = 0; i < phoneNumber.length; i++) {
      if (i == _spacePosition) {
        buffer.write(' ');
      }
      buffer.write(phoneNumber[i]);
    }

    return buffer.toString();
  }
}
