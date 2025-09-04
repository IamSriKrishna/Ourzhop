abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String mobileNumber;
  final String password;

  LoginRequested(this.mobileNumber, {required this.password});
}

class RegisterRequested extends AuthEvent {
  final String mobileNumber;

  RegisterRequested(this.mobileNumber);
}

class ValidationErrorTriggered extends AuthEvent {
  final String errorMessage;
  final String? field; // Add field parameter for specific field validation

  ValidationErrorTriggered(this.errorMessage, {this.field});
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

// Add SetPasswordRequested event
class SetPasswordRequested extends AuthEvent {
  final String password;
  SetPasswordRequested(this.password);
}