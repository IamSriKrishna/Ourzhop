
import 'package:customer_app/core/validation/phone_validation_service.dart';
import 'package:customer_app/features/auth/presentation/cubit/phone_textfield_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneTextFieldCubit extends Cubit<PhoneTextFieldState> {
  final String defaultCountryCode;
  final bool autoValidate;

  PhoneTextFieldCubit({
    required this.defaultCountryCode,
    this.autoValidate = false,
    String? initialText,
  }) : super(PhoneTextFieldState(
          phoneNumber: PhoneValidationService.parsePhoneNumber(
            initialText ?? '',
            defaultCountryCode: defaultCountryCode,
          ),
        )) {
    // Set initial phone controller text
    emit(state.copyWith(
      phoneControllerText: state.phoneNumber.formattedNumber,
    ));
  }

  void updateFocus(bool isFocused) {
    if (state.isFocused != isFocused) {
      emit(state.copyWith(isFocused: isFocused));
    }
  }

  void parseAndUpdateFromFullNumber(String fullNumber) {
    final newPhoneNumber = PhoneValidationService.parsePhoneNumber(
      fullNumber,
      defaultCountryCode: defaultCountryCode,
    );

    if (newPhoneNumber != state.phoneNumber) {
      emit(state.copyWith(
        phoneNumber: newPhoneNumber,
        phoneControllerText: newPhoneNumber.formattedNumber,
      ));
    }
  }

  void updatePhoneNumber({String? countryCode, String? number}) {
    final newPhoneNumber = state.phoneNumber.copyWith(
      countryCode: countryCode,
      number: number,
    );

    if (newPhoneNumber != state.phoneNumber) {
      emit(state.copyWith(
        phoneNumber: newPhoneNumber,
        phoneControllerText: newPhoneNumber.formattedNumber,
      ));
    }
  }

  void handlePhoneInputChange(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    updatePhoneNumber(number: digitsOnly);

    if (autoValidate) {
      _performAutoValidation();
    }
  }

  void _performAutoValidation() {
    final validationResult = PhoneValidationService.validatePhoneNumber(state.phoneNumber);
    // Handle validation result if needed
  }
}