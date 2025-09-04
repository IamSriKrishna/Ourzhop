// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Login Account';

  @override
  String get loginWelcomeMessage => 'Hello, Welcome back to your account.';

  @override
  String get loginPhoneNumber => 'Phone Number';

  @override
  String get loginRequestOtp => 'Request OTP';

  @override
  String get loginEnterMobileNumberPlaceholder => 'Enter Mobile Number';

  @override
  String get invalidMobileNumber =>
      'Please enter a valid 10-digit mobile number.';

  @override
  String get createButtonTitle => 'Create';

  @override
  String get signinPageTitle => 'Signin';

  @override
  String get signinButtonTitle => 'Sign In';

  @override
  String get signinProgressSendingOtp => 'Send otp...';

  @override
  String get verifyOtpPageTitle => 'Verification code';

  @override
  String get verifyOtpPageSubTitle =>
      'We have sent OTP code verification to your mobile no';

  @override
  String get verifyOtpEnterOtpHint => 'Enter OTP';

  @override
  String get verifyOtpButtonTitle => 'Verify';

  @override
  String get verifyOtpDidNotReceiveOtp => 'Didn’t get OTP Code ?';

  @override
  String get verifyOtpResendCode => 'Resend Code';

  @override
  String get verifyOtpProgressVerifying => 'Verifying OTP...';

  @override
  String get accountSetupPageTitle => 'Account setup';

  @override
  String get accountSetupPageSubTitle => 'Let\'s set up your account.';

  @override
  String get accountSetupName => 'Name';

  @override
  String get accountSetupEmail => 'Email';

  @override
  String get accountSetupButtonTitle => 'Continue';

  @override
  String get accountSetupNameHint => 'Enter Name';

  @override
  String get accountSetupEmailHint => 'Enter Email';

  @override
  String get accountSetupProgressVerifying => 'Account Setup Is Processing...';

  @override
  String get signupPageTitle => 'Sign Up';

  @override
  String get signupEnterNameHint => 'Enter Name';

  @override
  String get signupEnterEmailHint => 'Enter Email';

  @override
  String get signupEnterMobileHint => 'Enter Mobile';

  @override
  String get signupButtonTitle => 'Sign Up';

  @override
  String get signupProgressCreatingUser => 'Creating user...';

  @override
  String get signupMobileExistsMessage => 'Mobile number already exists';

  @override
  String get profilePageTitle => 'Profile';

  @override
  String get profileLogoutButtonTitle => 'Logout';

  @override
  String get profileProgressLogout => 'Logout...';

  @override
  String get createHubPageTitle => 'Create Hub';

  @override
  String get createHubButtonTitle => 'Create';

  @override
  String get editHubPageTitle => 'Edit Hub';

  @override
  String get editHubHubIdLabel => 'Hub ID';

  @override
  String get hubsPageTitle => 'Hubs';

  @override
  String get hubsCreateHubButtonTitle => 'Create Hub';

  @override
  String get hubsEditHubButtonTitle => 'Edit Hub';

  @override
  String get bottomNavHubs => 'Hubs';

  @override
  String get bottomNavCars => 'Cars';

  @override
  String get bottomNavUsers => 'Users';

  @override
  String get bottomNavProfile => 'Profile';

  @override
  String get usersPageTitle => 'Users';

  @override
  String get usersNoUserMessage => 'No users!';

  @override
  String get usersProgressCreating => 'Creating user...';

  @override
  String get usersProgressDeleting => 'Deleting user...';

  @override
  String get usersProgressUpdating => 'Updating user...';

  @override
  String get usersSuccessfullyCreated => 'Successfully created';

  @override
  String get usersSuccessfullyDeleted => 'Successfully deleted';

  @override
  String get usersSuccessfullyUpdated => 'Successfully updated';

  @override
  String get carsPageTitle => 'Cars';
}
