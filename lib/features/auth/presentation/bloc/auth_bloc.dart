// Package imports:
import 'dart:math';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bc;
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:customer_app/common/network/result/api_result.dart';
import 'package:customer_app/core/services/auth_preference_service.dart';
import 'package:customer_app/features/auth/data/models/user_model.dart';
import 'package:customer_app/features/auth/domain/usecases/account_setup_usecase.dart';
import 'package:customer_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:customer_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:customer_app/features/auth/domain/usecases/otp_verify_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /* ── dependencies ── */
  final LoginUseCase _login;
  final RegisterUseCase _register;
  final OtpVerifyUseCase _otpVerify;
  final AccountSetupUseCase _accountSetup;
  final AuthPreferenceService _prefs;
  
  /* ── bypass variables ── */
  String? _generatedOtp;
  String? _currentMobileNumber;
  String? _currentPassword; // Store password for account setup

  /* ── constructor ── */
  AuthBloc({
    required LoginUseCase login,
    required RegisterUseCase register,
    required OtpVerifyUseCase otpVerify,
    required AccountSetupUseCase accountSetup,
    required AuthPreferenceService prefs,
  })  : _login = login,
        _register = register,
        _otpVerify = otpVerify,
        _accountSetup = accountSetup,
        _prefs = prefs,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested, transformer: bc.droppable());
    on<RegisterRequested>(_onRegisterRequested, transformer: bc.droppable());
    on<ValidationErrorTriggered>(_onValidationErrorTriggered);
    on<ClearValidationError>(_onClearValidationError);
    on<OtpVerifyRequested>(_onOtpVerifyRequested, transformer: bc.droppable());
    on<AccountSetupRequested>(_onAccountSetupRequested, transformer: bc.droppable());
    on<SetPasswordRequested>(_onSetPasswordRequested, transformer: bc.droppable());
  }

  /* ─────────────────────  Login  ───────────────────── */
  Future<void> _onLoginRequested(
      LoginRequested e, Emitter<AuthState> emit) async {
    emit(SignInLoading());

    // Generate random OTP and store mobile number
    _generatedOtp = _generateRandomOtp();
    _currentMobileNumber = e.mobileNumber;

    // Simulate loading delay
    await Future.delayed(Duration(milliseconds: 500));

    // Emit success to navigate to OTP screen and show toast
    emit(NavigateToOtpWithToast(
      mobileNumber: e.mobileNumber,
      generatedOtp: _generatedOtp!,
      isFromLogin: true,
    ));
  }

  /* ─────────────────────  Register  ───────────────────── */
  Future<void> _onRegisterRequested(
      RegisterRequested e, Emitter<AuthState> emit) async {
    emit(SignUpLoading());

    // Generate random OTP and store mobile number
    _generatedOtp = _generateRandomOtp();
    _currentMobileNumber = e.mobileNumber;

    // Simulate loading delay
    await Future.delayed(Duration(milliseconds: 500));

    // Emit success to navigate to OTP screen and show toast
    emit(NavigateToOtpWithToast(
      mobileNumber: e.mobileNumber,
      generatedOtp: _generatedOtp!,
      isFromLogin: false,
    ));
  }

  /* ────────────────────  Validation  ─────────────────── */
  void _onValidationErrorTriggered(
      ValidationErrorTriggered e, Emitter<AuthState> emit) {
    emit(ValidationError(e.errorMessage, field: e.field));
  }

  void _onClearValidationError(
      ClearValidationError e, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  /* ────────────────────  OTP verify  ────────────────── */
  Future<void> _onOtpVerifyRequested(
      OtpVerifyRequested e, Emitter<AuthState> emit) async {
    emit(OtpVerifyLoading());

    // Simulate loading delay
    await Future.delayed(Duration(milliseconds: 800));

    // Check if entered OTP matches generated OTP
    if (e.otp == _generatedOtp) {
      // Save mock user data
      await _prefs.setLoggedIn(true);
      await _prefs.saveUser(UserModel(
        mobileNumber: e.mobileNumber,
        role: 'customer',
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        isNewUser: true, // Set to true to test new user flow, false for existing user
        name: null,
        email: null,
      ));
      
      // For bypass, let's assume it's a new user to show account setup
      emit(IsNewUser());
    } else {
      emit(OtpVerifyFailure('Invalid OTP. Please try again.'));
    }
  }

  /* ──────────────────  Account setup  ───────────────── */
  Future<void> _onAccountSetupRequested(
      AccountSetupRequested e, Emitter<AuthState> emit) async {
    emit(AccountSetupLoading());

    // Simulate loading delay
    await Future.delayed(Duration(milliseconds: 500));

    await _prefs.updateUserProfileInfo(
        name: e.name, email: e.email, isNewUser: false);
    emit(AccountSetupSuccess());
  }

  /* ──────────────────  Set Password  ───────────────── */
  Future<void> _onSetPasswordRequested(
      SetPasswordRequested e, Emitter<AuthState> emit) async {
    emit(SetPasswordLoading());

    try {
      // Store the password for later use
      _currentPassword = e.password;

      // Simulate API call delay
      await Future.delayed(Duration(milliseconds: 1000));

      // Simulate password setup success
      // In a real app, this would make an API call to set the password
      bool success = true; // Simulate success

      if (success) {
        // Update user preferences or make API call here
        // For now, just simulate success
        emit(SetPasswordSuccess());
      } else {
        emit(SetPasswordFailure('Failed to set password. Please try again.'));
      }
    } catch (e) {
      emit(SetPasswordFailure('An error occurred while setting password: $e'));
    }
  }

  /* ────────────────────  Helper methods  ────────────────── */
  String _generateRandomOtp() {
    final random = Random();
    final otp = (1000 + random.nextInt(9000)).toString(); // Generates 4-digit OTP
    print('Generated OTP: $otp'); // For debugging - remove in production
    return otp;
  }

  // Getters for testing purposes
  String? get generatedOtp => _generatedOtp;
  String? get currentMobileNumber => _currentMobileNumber;
  String? get currentPassword => _currentPassword;
}