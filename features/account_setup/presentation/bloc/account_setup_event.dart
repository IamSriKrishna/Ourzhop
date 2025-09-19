// Package imports:
import 'package:equatable/equatable.dart';

abstract class AccountSetupEvent extends Equatable {
  const AccountSetupEvent();

  @override
  List<Object?> get props => [];
}

// New events following login pattern
class AccountSetupNameChanged extends AccountSetupEvent {
  const AccountSetupNameChanged(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

class AccountSetupEmailChanged extends AccountSetupEvent {
  const AccountSetupEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class AccountSetupShowValidationError extends AccountSetupEvent {
  const AccountSetupShowValidationError();
}

class AccountSetupHideValidationError extends AccountSetupEvent {
  const AccountSetupHideValidationError();
}

// Existing event
class AccountSetupRequested extends AccountSetupEvent {
  const AccountSetupRequested(this.name, this.email);

  final String name;
  final String email;

  @override
  List<Object?> get props => [name, email];
}
