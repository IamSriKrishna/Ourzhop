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
  String get loginScreenTitle => 'உள்நுழைய';

  @override
  String get loginScreenSubtitle => 'உங்கள் மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String get mobileNumberLabel => 'மொபைல் எண்';

  @override
  String get verifyButtonTitle => 'சரிபார்க்கவும்';

  @override
  String get generatingOtpTitle => 'ஓடிபி உருவாக்கப்படுகிறது...';

  @override
  String get loginErrorTitle => 'உள்நுழைவு பிழை';

  @override
  String get phoneNumberValidationError =>
      'சரியான 10-இலக்க மொபைல் எண்ணை உள்ளிடவும்';

  @override
  String get phoneNumberRequired => 'மொபைல் எண் தேவை';

  @override
  String get phoneNumberTooShort =>
      'மொபைல் எண் சரியாக 10 இலக்கங்கள் இருக்க வேண்டும்';

  @override
  String get phoneNumberTooLong =>
      'மொபைல் எண் சரியாக 10 இலக்கங்கள் இருக்க வேண்டும்';

  @override
  String get phoneNumberInvalid =>
      'மொபைல் எண்ணில் இலக்கங்கள் மட்டுமே இருக்க வேண்டும்';

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
      'உங்கள் மொபைல் எண்ணிற்கு ஓடிபி அனுப்பப்பட்டுள்ளது';

  @override
  String get verifyOtpEnterOtpHint => 'ஓடிபி உள்ளிடவும்';

  @override
  String get verifyOtpButtonTitle => 'ஓடிபி சரிபார்க்கவும்';

  @override
  String get verifyOtpDidNotReceiveOtp => 'ஓடிபி கோட் கிடைக்கவில்லையா?';

  @override
  String get verifyOtpResendCode => 'மீண்டும் அனுப்பு';

  @override
  String get verifyOtpProgressVerifying => 'ஓடிபி சரிபார்க்கப்படுகிறது...';

  @override
  String get otpTitle => 'ஓடிபி';

  @override
  String get otpSubtitle => 'உங்கள் எண்ணிற்கு அனுப்பப்பட்ட ஓடிபியை உள்ளிடவும்';

  @override
  String get resendButtonTitle => 'மீண்டும் அனுப்பு';

  @override
  String get accountSetupPageTitle => 'கணக்கு அமைப்பு';

  @override
  String get accountSetupPageSubTitle => 'உங்கள் கணக்கை அமைப்போம்.';

  @override
  String get accountSetupName => 'பெயர்';

  @override
  String get accountSetupEmail => 'மின்னஞ்சல்';

  @override
  String get accountSetupButtonTitle => 'தொடரவும்';

  @override
  String get accountSetupNameHint => 'பெயர் உள்ளிடவும்';

  @override
  String get accountSetupEmailHint => 'மின்னஞ்சல் உள்ளிடவும்';

  @override
  String get accountSetupProgressVerifying =>
      'கணக்கு அமைப்பு செயலாக்கப்படுகிறது...';

  @override
  String get accountSetupNameRequired => 'பெயர் தேவை';

  @override
  String get accountSetupEmailRequired => 'மின்னஞ்சல் தேவை';

  @override
  String get accountSetupEmailInvalid =>
      'சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்';

  @override
  String get nameValidationEmpty => 'பெயர் தேவை';

  @override
  String get nameValidationTooShort =>
      'பெயர் குறைந்தது 2 எழுத்துகள் இருக்க வேண்டும்';

  @override
  String get nameValidationTooLong =>
      'பெயர் 50 எழுத்துகளுக்கு குறைவாக இருக்க வேண்டும்';

  @override
  String get nameValidationInvalid => 'பெயரில் தவறான எழுத்துகள் உள்ளன';

  @override
  String get emailValidationEmpty => 'மின்னஞ்சல் தேவை';

  @override
  String get emailValidationInvalid => 'சரியான மின்னஞ்சல் முகவரியை உள்ளிடவும்';

  @override
  String get emailValidationTooLong => 'மின்னஞ்சல் மிக நீளமானது';

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
  String get bottomNavHome => 'முகப்பு';

  @override
  String get bottomNavCategories => 'வகைகள்';

  @override
  String get bottomNavCart => 'கார்ட்';

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

  @override
  String get gettingLocationTitle => 'உங்கள் இருப்பிடம் கண்டறியப்படுகிறது...';

  @override
  String get selectLocationTitle => 'இருப்பிடத்தை தேர்ந்தெடுக்கவும்';

  @override
  String get selectLocationSubtitle =>
      'தற்போதைய இருப்பிடத்தை பயன்படுத்தவும் அல்லது உங்கள் சொந்த\nஇருப்பிடத்தை தேடவும்';

  @override
  String get noLocationsFound =>
      'உங்கள் தேடலுக்கு எந்த இருப்பிடமும் கிடைக்கவில்லை';

  @override
  String get searchLocationHint => 'பகுதி, தெரு தேடவும்...';

  @override
  String get useCurrentLocation => 'தற்போதைய இருப்பிடத்தை பயன்படுத்தவும்';

  @override
  String get locationDetected => 'இருப்பிடம் கண்டறியப்பட்டது';

  @override
  String get locationPermissionNeeded => 'இருப்பிட அனுமதி தேவை';

  @override
  String get continueButtonTitle => 'தொடரவும்';

  @override
  String get locationPermissionRequired =>
      'உங்கள் தற்போதைய இருப்பிடத்தைப் பெற இருப்பிட அனுமதி தேவை';

  @override
  String get setLocationTitle => 'உங்கள் இருப்பிடத்தை அமைக்கவும்';

  @override
  String get setLocationSubtitle =>
      'உங்கள் விருப்பமான இருப்பிடத்தைத் தேடி தேர்ந்தெடுக்கவும்';

  @override
  String get setLocationSearchHint => 'பகுதி, தெரு தேடவும்...';

  @override
  String get setLocationNoResults =>
      'உங்கள் தேடலுக்கு இருப்பிடங்கள் எதுவும் கிடைக்கவில்லை';

  @override
  String get setLocationSelectError => 'தொடர இருப்பிடத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get setLocationSaveError =>
      'இருப்பிடத்தைச் சேமிக்க முடியவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get setLocationNavigationError =>
      'வழிசெலுத்தல் தோல்வியுற்றது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get setLocationPageTitle => 'இருப்பிடத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get setLocationPageSubtitle =>
      'தற்போதைய இருப்பிடத்தைப் பயன்படுத்தவும் அல்லது உங்கள் சொந்த\nइருப்பிடத்தைத் தேடவும்';

  @override
  String get setLocationEmptySearchError => 'இருப்பிடத்தை உள்ளிடவும்';

  @override
  String get setLocationSearchTooShortError =>
      'இருப்பிட தேடலுக்கு குறைந்தது 3 எழுத்துகள் தேவை';

  @override
  String get setLocationSearchTooLongError =>
      'இருப்பிட தேடல் 100 எழுத்துகளை மீற முடியாது';

  @override
  String get setLocationInvalidSearchError => 'சரியான இருப்பிடத்தை உள்ளிடவும்';

  @override
  String get categoriesPageTitle => 'வகைகள்';

  @override
  String get categoriesLoadingMessage => 'வகைகள் ஏற்றப்படுகிறது...';

  @override
  String get categoriesLoadError => 'வகைகளை ஏற்ற முடியவில்லை';

  @override
  String get categoriesRetryButton => 'மீண்டும் முயற்சிக்கவும்';

  @override
  String get categoriesNoDataMessage => 'வகைகள் எதுவும் கிடைக்கவில்லை';

  @override
  String get categoriesLoadMoreButton => 'மேலும் ஏற்றவும்';
}
