// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/common/validation/otp_input.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object?> get props => [];
}

class OtpInitial extends OtpState {
  const OtpInitial({
    this.otp = const OtpInput.pure(),
    this.shouldShowValidationError = false,
  });

  final OtpInput otp;
  final bool shouldShowValidationError;

  @override
  List<Object?> get props => [otp, shouldShowValidationError];

  OtpInitial copyWith({
    OtpInput? otp,
    bool? shouldShowValidationError,
  }) {
    return OtpInitial(
      otp: otp ?? this.otp,
      shouldShowValidationError:
          shouldShowValidationError ?? this.shouldShowValidationError,
    );
  }

  // UI convenience getters (following login pattern)
  bool get isValid => otp.isValid;
  OtpValidationError? get otpError => otp.error;
  String get otpValue => otp.value;
}

class OtpVerifyLoading extends OtpState {
  const OtpVerifyLoading();
}

class OtpVerifySuccess extends OtpState {
  const OtpVerifySuccess();
}

class NeedsLocationSelection extends OtpState {
  const NeedsLocationSelection();
}

class OtpVerifyResend extends OtpState {
  const OtpVerifyResend({
    required this.timeRemaining,
    required this.isButtonEnabled,
    required this.resendAttempts,
  });

  final int timeRemaining;
  final bool isButtonEnabled;
  final int resendAttempts;

  @override
  List<Object?> get props => [timeRemaining, isButtonEnabled, resendAttempts];
}

class OtpVerifyFailure extends OtpState {
  const OtpVerifyFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

class IsNewUser extends OtpState {
  const IsNewUser();
}
