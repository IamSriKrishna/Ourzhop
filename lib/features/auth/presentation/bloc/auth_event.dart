abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String mobileNumber;

  LoginRequested(this.mobileNumber);
}

class ValidationErrorTriggered extends AuthEvent {
  final String errorMessage;

  ValidationErrorTriggered(this.errorMessage);
}

class ClearValidationError extends AuthEvent {}

class OtpVerifyRequested extends AuthEvent {
  final String mobileNumber;
  final String otp;
  OtpVerifyRequested(this.mobileNumber, this.otp);
}

class AccountSetupRequested extends AuthEvent {
  final String name;
  final String email;
  AccountSetupRequested(this.name, this.email);
}
