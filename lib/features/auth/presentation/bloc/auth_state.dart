// Flutter imports:
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInFailure extends AuthState {
  final String error;
  SignInFailure(this.error);
}

// Add validation error state for inline error display
class ValidationError extends AuthState {
  final String error;
  ValidationError(this.error);
}

class OtpVerifyLoading extends AuthState {}

class OtpVerifySuccess extends AuthState {}
// Add to your AuthState classes
class NeedsLocationSelection extends AuthState {
}
class OtpVerifyResend extends AuthState {
  final int timeRemaining;
  final bool isButtonEnabled;
  final int resendAttempts;

  OtpVerifyResend({
    required this.timeRemaining,
    required this.isButtonEnabled,
    required this.resendAttempts,
  });
}

class OtpVerifyFailure extends AuthState {
  final String error;
  OtpVerifyFailure(this.error);
}

class IsNewUser extends AuthState {}

class AccountSetupLoading extends AuthState {}

class AccountSetupSuccess extends AuthState {}

class AccountSetupFailure extends AuthState {
  final String error;
  AccountSetupFailure(this.error);
}
