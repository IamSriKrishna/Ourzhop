// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/validation/phone_input.dart';
import 'package:customer_app/features/login/domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /* ── dependencies ── */
  final LoginUseCase _login;

  /* ── constructor ── */
  LoginBloc({
    required LoginUseCase login,
  })  : _login = login,
        super(const LoginInitial()) {
    on<LoginRequested>(_onLoginRequested, transformer: bc.droppable());
    on<LoginPhoneNumberChanged>(_onLoginPhoneNumberChanged);
    on<LoginShowValidationError>(_onLoginShowValidationError);
    on<LoginHideValidationError>(_onLoginHideValidationError);
  }

  /* ─────────────────────  Login  ───────────────────── */
  Future<void> _onLoginRequested(
      LoginRequested e, Emitter<LoginState> emit) async {
    emit(const SignInLoading());

    final result = await _login(LoginParams(e.mobileNumber));
    switch (result) {
      case Success():
        emit(const SignInSuccess());
      case Failure():
        emit(SignInFailure(result.error.message));
    }
  }

  /* ───────────────────  Login Phone Validation  ────────────── */
  void _onLoginPhoneNumberChanged(
      LoginPhoneNumberChanged event, Emitter<LoginState> emit) {
    // Only emit state change if currently in LoginInitial to avoid unnecessary rebuilds
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      final phoneNumber = LoginPhoneNumber.dirty(event.phoneDigits);

      // Hide validation errors during typing - let FormZ handle validation
      emit(currentState.copyWith(
        phoneNumber: phoneNumber,
        shouldShowValidationError: false,
      ));
    }
  }

  /* ───────────────────  Login Validation Error Control  ────────────── */
  void _onLoginShowValidationError(
      LoginShowValidationError event, Emitter<LoginState> emit) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      emit(currentState.copyWith(shouldShowValidationError: true));
    }
  }

  void _onLoginHideValidationError(
      LoginHideValidationError event, Emitter<LoginState> emit) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      emit(currentState.copyWith(shouldShowValidationError: false));
    }
  }
}
