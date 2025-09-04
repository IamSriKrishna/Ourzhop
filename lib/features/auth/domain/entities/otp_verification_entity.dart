// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

@immutable
class OtpVerificationEntity {
  final String token;
  final bool isNewUser;
  final String role;

  const OtpVerificationEntity({
    required this.token,
    required this.isNewUser,
    required this.role,
  });
}
