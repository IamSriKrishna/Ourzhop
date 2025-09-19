// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/validation/email_input.dart';
import 'package:customer_app/common/validation/name_input.dart';
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/features/account_setup/domain/usecases/account_setup_usecase.dart';
import 'account_setup_event.dart';
import 'account_setup_state.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  /* ── dependencies ── */
  final AccountSetupUseCase _accountSetup;
  final UserPreferenceService _prefs;

  /* ── constructor ── */
  AccountSetupBloc({
    required AccountSetupUseCase accountSetup,
    required UserPreferenceService prefs,
  })  : _accountSetup = accountSetup,
        _prefs = prefs,
        super(const AccountSetupInitial()) {
    // Use droppable transformer for async operations to prevent race conditions
    on<AccountSetupRequested>(_onAccountSetupRequested,
        transformer: bc.droppable());

    // Immediate state updates (no transformer needed)
    on<AccountSetupNameChanged>(_onAccountSetupNameChanged);
    on<AccountSetupEmailChanged>(_onAccountSetupEmailChanged);
    on<AccountSetupShowValidationError>(_onAccountSetupShowValidationError);
    on<AccountSetupHideValidationError>(_onAccountSetupHideValidationError);
  }

  /* ──────────────────  Account setup  ───────────────── */
  Future<void> _onAccountSetupRequested(
      AccountSetupRequested e, Emitter<AccountSetupState> emit) async {
    emit(const AccountSetupLoading());

    final result = await _accountSetup(AccountParams(e.name, e.email));
    switch (result) {
      case Success():
        await _prefs.updateProfileUserInfo(
            name: e.name, email: e.email, isNewUser: false);
        emit(const AccountSetupSuccess());
      case Failure():
        emit(AccountSetupFailure(result.error.message));
    }
  }

  /* ────────────────────  New validation event handlers  ────────────────── */
  void _onAccountSetupNameChanged(
      AccountSetupNameChanged event, Emitter<AccountSetupState> emit) {
    if (state is! AccountSetupInitial) return;

    final currentState = state as AccountSetupInitial;
    final newName = AccountSetupName.dirty(event.name);

    emit(currentState.copyWith(
      name: newName,
      // Auto-hide validation error when user starts typing (like login)
      shouldShowValidationError: false,
    ));
  }

  void _onAccountSetupEmailChanged(
      AccountSetupEmailChanged event, Emitter<AccountSetupState> emit) {
    if (state is! AccountSetupInitial) return;

    final currentState = state as AccountSetupInitial;
    final newEmail = AccountSetupEmail.dirty(event.email);

    emit(currentState.copyWith(
      email: newEmail,
      // Auto-hide validation error when user starts typing (like login)
      shouldShowValidationError: false,
    ));
  }

  void _onAccountSetupShowValidationError(
      AccountSetupShowValidationError event, Emitter<AccountSetupState> emit) {
    if (state is! AccountSetupInitial) return;

    final currentState = state as AccountSetupInitial;
    emit(currentState.copyWith(shouldShowValidationError: true));
  }

  void _onAccountSetupHideValidationError(
      AccountSetupHideValidationError event, Emitter<AccountSetupState> emit) {
    if (state is! AccountSetupInitial) return;

    final currentState = state as AccountSetupInitial;
    emit(currentState.copyWith(shouldShowValidationError: false));
  }
}
