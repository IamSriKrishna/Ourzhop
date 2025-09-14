class PhoneNumber {
  final String countryCode;
  final String number;

  const PhoneNumber({
    required this.countryCode,
    required this.number,
  });

  String get fullNumber => '$countryCode$number';
  String get displayNumber => '$countryCode $formattedNumber';

  String get formattedNumber {
    final digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 5) return digits;

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i == 5) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  PhoneNumber copyWith({String? countryCode, String? number}) {
    return PhoneNumber(
      countryCode: countryCode ?? this.countryCode,
      number: number ?? this.number,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneNumber &&
          runtimeType == other.runtimeType &&
          countryCode == other.countryCode &&
          number == other.number;

  @override
  int get hashCode => countryCode.hashCode ^ number.hashCode;

  @override
  String toString() =>
      'PhoneNumber(countryCode: $countryCode, number: $number)';
}
