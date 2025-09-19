// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:customer_app/common/validation/email_input.dart';
import 'package:customer_app/common/validation/name_input.dart';

abstract class AccountSetupState extends Equatable {
  const AccountSetupState();

  @override
  List<Object?> get props => [];
}

class AccountSetupInitial extends AccountSetupState {
  const AccountSetupInitial({
    this.name = const AccountSetupName.pure(),
    this.email = const AccountSetupEmail.pure(),
    this.shouldShowValidationError = false,
  });

  final AccountSetupName name;
  final AccountSetupEmail email;
  final bool shouldShowValidationError;

  @override
  List<Object?> get props => [name, email, shouldShowValidationError];

  AccountSetupInitial copyWith({
    AccountSetupName? name,
    AccountSetupEmail? email,
    bool? shouldShowValidationError,
  }) {
    return AccountSetupInitial(
      name: name ?? this.name,
      email: email ?? this.email,
      shouldShowValidationError:
          shouldShowValidationError ?? this.shouldShowValidationError,
    );
  }

  // UI convenience getters (following login pattern)
  bool get isValid => name.isValid && email.isValid;
  NameValidationError? get nameError => name.error;
  EmailValidationError? get emailError => email.error;
  String get nameValue => name.value;
  String get emailValue => email.value;
}

class AccountSetupLoading extends AccountSetupState {
  const AccountSetupLoading();
}

class AccountSetupSuccess extends AccountSetupState {
  const AccountSetupSuccess();
}

class AccountSetupFailure extends AccountSetupState {
  const AccountSetupFailure(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
