// Package imports:
import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

// New events following login pattern
class OtpChanged extends OtpEvent {
  const OtpChanged(this.otp);

  final String otp;

  @override
  List<Object?> get props => [otp];
}

class OtpShowValidationError extends OtpEvent {
  const OtpShowValidationError();
}

class OtpHideValidationError extends OtpEvent {
  const OtpHideValidationError();
}

class OtpResetToInitial extends OtpEvent {
  const OtpResetToInitial();
}

// Existing events
class OtpVerifyRequested extends OtpEvent {
  const OtpVerifyRequested(this.mobileNumber, this.otp);

  final String mobileNumber;
  final String otp;

  @override
  List<Object?> get props => [mobileNumber, otp];
}

class OtpResendRequested extends OtpEvent {
  const OtpResendRequested(this.mobileNumber);

  final String mobileNumber;

  @override
  List<Object?> get props => [mobileNumber];
}
