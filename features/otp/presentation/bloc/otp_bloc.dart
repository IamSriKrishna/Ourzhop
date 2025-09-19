// Package imports:
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/common/validation/otp_input.dart';
import 'package:customer_app/core/models/user_model.dart';
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/features/login/domain/usecases/login_usecase.dart';
import 'package:customer_app/features/otp/domain/usecases/otp_usecase.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  /* ── dependencies ── */
  final OtpUseCase _otpVerify;
  final LoginUseCase _loginUseCase; // For resend functionality
  final UserPreferenceService _prefs;

  /* ── constructor ── */
  OtpBloc({
    required OtpUseCase otpVerify,
    required LoginUseCase loginUseCase,
    required UserPreferenceService prefs,
  })  : _otpVerify = otpVerify,
        _loginUseCase = loginUseCase,
        _prefs = prefs,
        super(const OtpInitial()) {
    // Use droppable transformer for async operations to prevent race conditions
    on<OtpVerifyRequested>(_onOtpVerifyRequested, transformer: bc.droppable());
    on<OtpResendRequested>(_onOtpResendRequested, transformer: bc.droppable());

    // Immediate state updates (no transformer needed)
    on<OtpChanged>(_onOtpChanged);
    on<OtpShowValidationError>(_onOtpShowValidationError);
    on<OtpHideValidationError>(_onOtpHideValidationError);
    on<OtpResetToInitial>(_onOtpResetToInitial);
  }

  /* ────────────────────  OTP verify  ────────────────── */
  Future<void> _onOtpVerifyRequested(
      OtpVerifyRequested e, Emitter<OtpState> emit) async {
    emit(const OtpVerifyLoading());

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
          emit(const IsNewUser());
        } else {
          // For existing users, check if they have selected location
          final hasLocation = await _prefs.isLocationAvailable();
          if (hasLocation) {
            emit(const OtpVerifySuccess());
          } else {
            emit(const NeedsLocationSelection());
          }
        }
      case Failure():
        emit(OtpVerifyFailure(result.error.message));
    }
  }

  /* ────────────────────  OTP resend  ────────────────── */
  Future<void> _onOtpResendRequested(
      OtpResendRequested e, Emitter<OtpState> emit) async {
    // Use the login use case to resend OTP
    final result = await _loginUseCase(LoginParams(e.mobileNumber));
    switch (result) {
      case Success():
        // Emit resend state with timer (you can customize the timer logic)
        emit(const OtpVerifyResend(
          timeRemaining: 30,
          isButtonEnabled: false,
          resendAttempts: 1,
        ));
      case Failure():
        emit(OtpVerifyFailure(result.error.message));
    }
  }

  /* ────────────────────  New validation event handlers  ────────────────── */
  void _onOtpChanged(OtpChanged event, Emitter<OtpState> emit) {
    // CRITICAL FIX: Always transition to OtpInitial when user types, regardless of current state
    // This ensures auto-trigger works after error states (following login pattern)
    final newOtp = OtpInput.dirty(event.otp);

    emit(OtpInitial(
      otp: newOtp,
      // Auto-hide validation error when user starts typing (like login)
      shouldShowValidationError: false,
    ));
  }

  void _onOtpShowValidationError(
      OtpShowValidationError event, Emitter<OtpState> emit) {
    if (state is! OtpInitial) return;

    final currentState = state as OtpInitial;
    emit(currentState.copyWith(shouldShowValidationError: true));
  }

  void _onOtpHideValidationError(
      OtpHideValidationError event, Emitter<OtpState> emit) {
    if (state is! OtpInitial) return;

    final currentState = state as OtpInitial;
    emit(currentState.copyWith(shouldShowValidationError: false));
  }

  void _onOtpResetToInitial(OtpResetToInitial event, Emitter<OtpState> emit) {
    // Reset to initial state - this allows retries after failures
    emit(const OtpInitial());
  }
}
