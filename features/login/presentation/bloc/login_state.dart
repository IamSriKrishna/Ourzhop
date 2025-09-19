// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/common/validation/phone_input.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial({
    this.phoneNumber = const LoginPhoneNumber.pure(),
    this.shouldShowValidationError = false,
  });

  final LoginPhoneNumber phoneNumber;
  final bool shouldShowValidationError;

  @override
  List<Object?> get props => [phoneNumber, shouldShowValidationError];

  LoginInitial copyWith({
    LoginPhoneNumber? phoneNumber,
    bool? shouldShowValidationError,
  }) {
    return LoginInitial(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      shouldShowValidationError:
          shouldShowValidationError ?? this.shouldShowValidationError,
    );
  }

  // UI convenience getters
  bool get isValid => phoneNumber.isValid;
  PhoneValidationError? get phoneError => phoneNumber.error;
  String get phoneValue => phoneNumber.value;
}

class SignInLoading extends LoginState {
  const SignInLoading();
}

class SignInSuccess extends LoginState {
  const SignInSuccess();
}

class SignInFailure extends LoginState {
  const SignInFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
