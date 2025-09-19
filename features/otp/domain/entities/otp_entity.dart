// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

@immutable
class OtpEntity {
  final String token;
  final bool isNewUser;
  final String role;

  const OtpEntity({
    required this.token,
    required this.isNewUser,
    required this.role,
  });
}
