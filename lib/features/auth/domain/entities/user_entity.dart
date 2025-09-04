// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserEntity {
  final String mobileNumber;
  final String role;
  final String token;
  final bool isNewUser;
  final String? name;
  final String? email;

  const UserEntity({
    required this.mobileNumber,
    required this.role,
    required this.token,
    required this.isNewUser,
    this.name,
    this.email,
  });
}
