// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

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
  String get createButtonTitle => 'உருவாக்கு';

  @override
  String get signinPageTitle => 'உள்நுழைய';

  @override
  String get signinButtonTitle => 'உள்நுழையவும்';

  @override
  String get signinProgressSendingOtp => 'ஓடிபி அனுப்பப்படுகிறது...';

  @override
  String get verifyOtpPageTitle => 'ஓடிபி சரிபார்க்கவும்';

  @override
  String get verifyOtpPageSubTitle =>
      'We have sent OTP code verification to your mobile no';

  @override
  String get verifyOtpEnterOtpHint => 'ஓடிபி உள்ளிடவும்';

  @override
  String get verifyOtpButtonTitle => 'ஓடிபி சரிபார்க்கவும்';

  @override
  String get verifyOtpDidNotReceiveOtp => 'Didn’t get OTP Code ?';

  @override
  String get verifyOtpResendCode => 'Resend Code';

  @override
  String get verifyOtpProgressVerifying => 'ஓடிபி சரிபார்க்கப்படுகிறது...';

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
  String get signupPageTitle => 'பதிவு செய்ய';

  @override
  String get signupEnterNameHint => 'பெயர் உள்ளிடவும்';

  @override
  String get signupEnterEmailHint => 'மின்னஞ்சல் உள்ளிடவும்';

  @override
  String get signupEnterMobileHint => 'மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String get signupButtonTitle => 'பதிவு செய்யவும்';

  @override
  String get signupProgressCreatingUser => 'பயனர் உருவாக்கப்படுகிறார்...';

  @override
  String get signupMobileExistsMessage => 'மொபைல் எண் ஏற்கனவே உள்ளது';

  @override
  String get profilePageTitle => 'சுயவிவரம்';

  @override
  String get profileLogoutButtonTitle => 'வெளியேறு';

  @override
  String get profileProgressLogout => 'வெளியேறு...';

  @override
  String get createHubPageTitle => 'ஹப் உருவாக்கு';

  @override
  String get createHubButtonTitle => 'உருவாக்கு';

  @override
  String get editHubPageTitle => 'ஹப் திருத்து';

  @override
  String get editHubHubIdLabel => 'ஹப் ஐடி';

  @override
  String get hubsPageTitle => 'ஹப்கள்';

  @override
  String get hubsCreateHubButtonTitle => 'ஹப் உருவாக்கு';

  @override
  String get hubsEditHubButtonTitle => 'ஹப் திருத்து';

  @override
  String get bottomNavHubs => 'ஹப்கள்';

  @override
  String get bottomNavCars => 'கார்கள்';

  @override
  String get bottomNavUsers => 'பயனர்கள்';

  @override
  String get bottomNavProfile => 'சுயவிவரம்';

  @override
  String get usersPageTitle => 'பயனர்கள்';

  @override
  String get usersNoUserMessage => 'பயனர்கள் இல்லை!';

  @override
  String get usersProgressCreating => 'பயனர் உருவாக்கப்படுகிறார்...';

  @override
  String get usersProgressDeleting => 'பயனர் அழிக்கப்படுகிறார்...';

  @override
  String get usersProgressUpdating => 'பயனர் புதுப்பிக்கப்படுகிறார்...';

  @override
  String get usersSuccessfullyCreated => 'வெற்றிகரமாக உருவாக்கப்பட்டது';

  @override
  String get usersSuccessfullyDeleted => 'வெற்றிகரமாக அழிக்கப்பட்டது';

  @override
  String get usersSuccessfullyUpdated => 'வெற்றிகரமாக புதுப்பிக்கப்பட்டது';

  @override
  String get carsPageTitle => 'கார்கள்';
}
