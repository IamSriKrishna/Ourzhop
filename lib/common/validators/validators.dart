class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name cannot be empty';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || !value.contains(RegExp(r'@[a-zA-Z_]'))) {
      return 'Email is invalid';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) return 'Mobile cannot be empty';
    return null;
  }

  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) return 'Otp cannot be empty';
    return null;
  }
}
