import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

// Login States
class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final String? generatedOtp; // Add OTP for notification
  SignInSuccess({this.generatedOtp});
}

class SignInFailure extends AuthState {
  final String error;
  SignInFailure(this.error);
}

// Registration States
class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final String? generatedOtp; // Add OTP for notification
  SignUpSuccess({this.generatedOtp});
}

class SignUpFailure extends AuthState {
  final String error;
  SignUpFailure(this.error);
}

// New state for navigating to OTP with toast
class NavigateToOtpWithToast extends AuthState {
  final String mobileNumber;
  final String generatedOtp;
  final bool isFromLogin;

  NavigateToOtpWithToast({
    required this.mobileNumber,
    required this.generatedOtp,
    required this.isFromLogin,
  });
}

// Updated validation error state for field-specific inline error display
class ValidationError extends AuthState {
  final String error;
  final String? field; // Add field parameter to identify which field has error

  ValidationError(this.error, {this.field});
}

// OTP States
class OtpVerifyLoading extends AuthState {}

class OtpVerifySuccess extends AuthState {}

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

// Account Setup States
class IsNewUser extends AuthState {}

class AccountSetupLoading extends AuthState {}

class AccountSetupSuccess extends AuthState {}

class AccountSetupFailure extends AuthState {
  final String error;
  AccountSetupFailure(this.error);
}

// Set Password States
class SetPasswordLoading extends AuthState {}

class SetPasswordSuccess extends AuthState {}

class SetPasswordFailure extends AuthState {
  final String error;
  SetPasswordFailure(this.error);
}