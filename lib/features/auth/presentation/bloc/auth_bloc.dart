// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/auth/domain/usecases/account_setup_usecase.dart';
import 'package:customer_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:customer_app/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /* ── dependencies ── */
  final LoginUseCase _login;
  final OtpVerifyUseCase _otpVerify;
  final AccountSetupUseCase _accountSetup;
  final AuthPreferenceService _prefs;

  /* ── constructor ── */
  AuthBloc({
    required LoginUseCase login,
    required OtpVerifyUseCase otpVerify,
    required AccountSetupUseCase accountSetup,
    required AuthPreferenceService prefs,
  })  : _login = login,
        _otpVerify = otpVerify,
        _accountSetup = accountSetup,
        _prefs = prefs,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested, transformer: bc.droppable());
    on<ValidationErrorTriggered>(_onValidationErrorTriggered);
    on<ClearValidationError>(_onClearValidationError);
    on<OtpVerifyRequested>(_onOtpVerifyRequested, transformer: bc.droppable());
    on<AccountSetupRequested>(_onAccountSetupRequested,
        transformer: bc.droppable());
  }

  /* ─────────────────────  Login  ───────────────────── */
  Future<void> _onLoginRequested(
      LoginRequested e, Emitter<AuthState> emit) async {
    emit(SignInLoading());

    final result = await _login(LoginParams(e.mobileNumber));
    switch (result) {
      case Success():
        emit(SignInSuccess());
      case Failure():
        emit(SignInFailure(result.error.message));
    }
  }

  /* ────────────────────  Validation  ─────────────────── */
  void _onValidationErrorTriggered(
      ValidationErrorTriggered e, Emitter<AuthState> emit) {
    emit(ValidationError(e.errorMessage));
  }

  void _onClearValidationError(
      ClearValidationError e, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  /* ────────────────────  OTP verify  ────────────────── */
Future<void> _onOtpVerifyRequested(
    OtpVerifyRequested e, Emitter<AuthState> emit) async {
  emit(OtpVerifyLoading());

  final result = await _otpVerify(OtpParams(e.mobileNumber, e.otp));
  switch (result) {
    case Success():
      final d = result.data;
      await _prefs.setLoggedIn(true);
      
      // Save user data
      await _prefs.saveUser(UserModel(
        mobileNumber: e.mobileNumber,
        role: d.role,
        token: d.token,
        isNewUser: d.isNewUser,
        name: null,
        email: null,
        location: null, // Make sure location is initially null
      ));

      // Check if user needs to complete setup or select location
      if (d.isNewUser) {
        emit(IsNewUser());
      } else {
        // For existing users, check if they have selected location
        final hasLocation = await _prefs.hasSelectedLocation();
        if (hasLocation) {
          emit(OtpVerifySuccess());
        } else {
          emit(NeedsLocationSelection());
        }
      }
    case Failure():
      emit(OtpVerifyFailure(result.error.message));
  }
}

  /* ──────────────────  Account setup  ───────────────── */
  Future<void> _onAccountSetupRequested(
      AccountSetupRequested e, Emitter<AuthState> emit) async {
    emit(AccountSetupLoading());

    final result = await _accountSetup(AccountParams(e.name, e.email));
    switch (result) {
      case Success():
        await _prefs.updateUserProfileInfo(
            name: e.name, email: e.email, isNewUser: false);
        emit(AccountSetupSuccess());
      case Failure():
        emit(AccountSetupFailure(result.error.message));
    }
  }
}
