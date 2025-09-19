// Package imports:
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent {
  const LoginRequested(this.mobileNumber);

  final String mobileNumber;

  @override
  List<Object?> get props => [mobileNumber];
}

class LoginPhoneNumberChanged extends LoginEvent {
  const LoginPhoneNumberChanged(this.phoneDigits);

  final String phoneDigits; // Raw digits from text field (0-10 digits)

  @override
  List<Object?> get props => [phoneDigits];
}

class LoginShowValidationError extends LoginEvent {
  const LoginShowValidationError();
}

class LoginHideValidationError extends LoginEvent {
  const LoginHideValidationError();
}
