class OtpData {
  final String phoneNumber;
  final String otp;
  final int resendTimeInSeconds;

  const OtpData({
    required this.phoneNumber,
    required this.otp,
    this.resendTimeInSeconds = 30,
  });

  OtpData copyWith({
    String? phoneNumber,
    String? otp,
    int? resendTimeInSeconds,
  }) {
    return OtpData(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      resendTimeInSeconds: resendTimeInSeconds ?? this.resendTimeInSeconds,
    );
  }

  String get formattedPhoneNumber => phoneNumber.replaceAll(RegExp(r'\D'), '');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtpData &&
          runtimeType == other.runtimeType &&
          phoneNumber == other.phoneNumber &&
          otp == other.otp &&
          resendTimeInSeconds == other.resendTimeInSeconds;

  @override
  int get hashCode =>
      phoneNumber.hashCode ^ otp.hashCode ^ resendTimeInSeconds.hashCode;

  @override
  String toString() =>
      'OtpData(phoneNumber: $phoneNumber, otp: $otp, resendTime: $resendTimeInSeconds)';
}
