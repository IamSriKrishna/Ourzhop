
import 'package:customer_app/core/models/phone_number.dart';
import 'package:equatable/equatable.dart';

class PhoneTextFieldState extends Equatable {
  final PhoneNumber phoneNumber;
  final bool isFocused;
  final String phoneControllerText;

  const PhoneTextFieldState({
    required this.phoneNumber,
    this.isFocused = false,
    this.phoneControllerText = '',
  });

  PhoneTextFieldState copyWith({
    PhoneNumber? phoneNumber,
    bool? isFocused,
    String? phoneControllerText,
  }) {
    return PhoneTextFieldState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isFocused: isFocused ?? this.isFocused,
      phoneControllerText: phoneControllerText ?? this.phoneControllerText,
    );
  }

  @override
  List<Object?> get props => [phoneNumber, isFocused, phoneControllerText];
}