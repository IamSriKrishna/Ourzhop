class PhoneFormatter {
  static String formatPhoneNumber(String phoneNumber,
      {String separator = ' '}) {
    if (phoneNumber.length <= 3) return phoneNumber;
    final countryCode = phoneNumber.substring(0, 3);
    final rest = phoneNumber.substring(3);
    return '$countryCode$separator$rest';
  }

  static String formatWithPattern(String phoneNumber, String pattern) {
    var result = pattern;
    for (var char in phoneNumber.split('')) {
      result = result.replaceFirst('X', char);
    }
    return result;
  }
}
