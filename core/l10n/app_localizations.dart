import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ta.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ta')
  ];

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Account'**
  String get loginTitle;

  /// No description provided for @loginWelcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, Welcome back to your account.'**
  String get loginWelcomeMessage;

  /// No description provided for @loginPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get loginPhoneNumber;

  /// No description provided for @loginRequestOtp.
  ///
  /// In en, this message translates to:
  /// **'Request OTP'**
  String get loginRequestOtp;

  /// No description provided for @loginEnterMobileNumberPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get loginEnterMobileNumberPlaceholder;

  /// No description provided for @invalidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 10-digit mobile number.'**
  String get invalidMobileNumber;

  /// No description provided for @loginScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginScreenTitle;

  /// No description provided for @loginScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number'**
  String get loginScreenSubtitle;

  /// No description provided for @mobileNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumberLabel;

  /// No description provided for @verifyButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButtonTitle;

  /// No description provided for @generatingOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Generating OTP...'**
  String get generatingOtpTitle;

  /// No description provided for @loginErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get loginErrorTitle;

  /// No description provided for @phoneNumberValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 10-digit mobile number'**
  String get phoneNumberValidationError;

  /// No description provided for @phoneNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneNumberRequired;

  /// No description provided for @phoneNumberTooShort.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 10 digits'**
  String get phoneNumberTooShort;

  /// No description provided for @phoneNumberTooLong.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be exactly 10 digits'**
  String get phoneNumberTooLong;

  /// No description provided for @phoneNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'Phone number must contain only digits'**
  String get phoneNumberInvalid;

  /// No description provided for @createButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createButtonTitle;

  /// No description provided for @signinPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Signin'**
  String get signinPageTitle;

  /// No description provided for @signinButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signinButtonTitle;

  /// No description provided for @signinProgressSendingOtp.
  ///
  /// In en, this message translates to:
  /// **'Send otp...'**
  String get signinProgressSendingOtp;

  /// No description provided for @verifyOtpPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verifyOtpPageTitle;

  /// No description provided for @verifyOtpPageSubTitle.
  ///
  /// In en, this message translates to:
  /// **'We have sent OTP code verification to your mobile no'**
  String get verifyOtpPageSubTitle;

  /// No description provided for @verifyOtpEnterOtpHint.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get verifyOtpEnterOtpHint;

  /// No description provided for @verifyOtpButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyOtpButtonTitle;

  /// No description provided for @verifyOtpDidNotReceiveOtp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get OTP Code ?'**
  String get verifyOtpDidNotReceiveOtp;

  /// No description provided for @verifyOtpResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get verifyOtpResendCode;

  /// No description provided for @verifyOtpProgressVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying OTP...'**
  String get verifyOtpProgressVerifying;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the OTP sent to your number'**
  String get otpSubtitle;

  /// No description provided for @resendButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendButtonTitle;

  /// No description provided for @accountSetupPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Account setup'**
  String get accountSetupPageTitle;

  /// No description provided for @accountSetupPageSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your account.'**
  String get accountSetupPageSubTitle;

  /// No description provided for @accountSetupName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get accountSetupName;

  /// No description provided for @accountSetupEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountSetupEmail;

  /// No description provided for @accountSetupButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get accountSetupButtonTitle;

  /// No description provided for @accountSetupNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get accountSetupNameHint;

  /// No description provided for @accountSetupEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get accountSetupEmailHint;

  /// No description provided for @accountSetupProgressVerifying.
  ///
  /// In en, this message translates to:
  /// **'Account Setup Is Processing...'**
  String get accountSetupProgressVerifying;

  /// No description provided for @accountSetupNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get accountSetupNameRequired;

  /// No description provided for @accountSetupEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get accountSetupEmailRequired;

  /// No description provided for @accountSetupEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get accountSetupEmailInvalid;

  /// No description provided for @nameValidationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameValidationEmpty;

  /// No description provided for @nameValidationTooShort.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameValidationTooShort;

  /// No description provided for @nameValidationTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be less than 50 characters'**
  String get nameValidationTooLong;

  /// No description provided for @nameValidationInvalid.
  ///
  /// In en, this message translates to:
  /// **'Name contains invalid characters'**
  String get nameValidationInvalid;

  /// No description provided for @emailValidationEmpty.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailValidationEmpty;

  /// No description provided for @emailValidationInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailValidationInvalid;

  /// No description provided for @emailValidationTooLong.
  ///
  /// In en, this message translates to:
  /// **'Email is too long'**
  String get emailValidationTooLong;

  /// No description provided for @signupPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signupPageTitle;

  /// No description provided for @signupEnterNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get signupEnterNameHint;

  /// No description provided for @signupEnterEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get signupEnterEmailHint;

  /// No description provided for @signupEnterMobileHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile'**
  String get signupEnterMobileHint;

  /// No description provided for @signupButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signupButtonTitle;

  /// No description provided for @signupProgressCreatingUser.
  ///
  /// In en, this message translates to:
  /// **'Creating user...'**
  String get signupProgressCreatingUser;

  /// No description provided for @signupMobileExistsMessage.
  ///
  /// In en, this message translates to:
  /// **'Mobile number already exists'**
  String get signupMobileExistsMessage;

  /// No description provided for @profilePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profilePageTitle;

  /// No description provided for @profileLogoutButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileLogoutButtonTitle;

  /// No description provided for @profileProgressLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout...'**
  String get profileProgressLogout;

  /// No description provided for @createHubPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Hub'**
  String get createHubPageTitle;

  /// No description provided for @createHubButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createHubButtonTitle;

  /// No description provided for @editHubPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Hub'**
  String get editHubPageTitle;

  /// No description provided for @editHubHubIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Hub ID'**
  String get editHubHubIdLabel;

  /// No description provided for @hubsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Hubs'**
  String get hubsPageTitle;

  /// No description provided for @hubsCreateHubButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Hub'**
  String get hubsCreateHubButtonTitle;

  /// No description provided for @hubsEditHubButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Hub'**
  String get hubsEditHubButtonTitle;

  /// No description provided for @bottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomNavHome;

  /// No description provided for @bottomNavCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get bottomNavCategories;

  /// No description provided for @bottomNavCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get bottomNavCart;

  /// No description provided for @usersPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersPageTitle;

  /// No description provided for @usersNoUserMessage.
  ///
  /// In en, this message translates to:
  /// **'No users!'**
  String get usersNoUserMessage;

  /// No description provided for @usersProgressCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating user...'**
  String get usersProgressCreating;

  /// No description provided for @usersProgressDeleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting user...'**
  String get usersProgressDeleting;

  /// No description provided for @usersProgressUpdating.
  ///
  /// In en, this message translates to:
  /// **'Updating user...'**
  String get usersProgressUpdating;

  /// No description provided for @usersSuccessfullyCreated.
  ///
  /// In en, this message translates to:
  /// **'Successfully created'**
  String get usersSuccessfullyCreated;

  /// No description provided for @usersSuccessfullyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Successfully deleted'**
  String get usersSuccessfullyDeleted;

  /// No description provided for @usersSuccessfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Successfully updated'**
  String get usersSuccessfullyUpdated;

  /// No description provided for @carsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Cars'**
  String get carsPageTitle;

  /// No description provided for @gettingLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Getting your location...'**
  String get gettingLocationTitle;

  /// No description provided for @selectLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get selectLocationTitle;

  /// No description provided for @selectLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use current location or search your own\nlocation'**
  String get selectLocationSubtitle;

  /// No description provided for @noLocationsFound.
  ///
  /// In en, this message translates to:
  /// **'No locations found for your search'**
  String get noLocationsFound;

  /// No description provided for @searchLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Search for area, street...'**
  String get searchLocationHint;

  /// No description provided for @useCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use current location'**
  String get useCurrentLocation;

  /// No description provided for @locationDetected.
  ///
  /// In en, this message translates to:
  /// **'Location detected'**
  String get locationDetected;

  /// No description provided for @locationPermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Need to give location permission'**
  String get locationPermissionNeeded;

  /// No description provided for @continueButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonTitle;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to get your current location'**
  String get locationPermissionRequired;

  /// No description provided for @setLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Your Location'**
  String get setLocationTitle;

  /// No description provided for @setLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search and select your preferred location'**
  String get setLocationSubtitle;

  /// No description provided for @setLocationSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for area, street...'**
  String get setLocationSearchHint;

  /// No description provided for @setLocationNoResults.
  ///
  /// In en, this message translates to:
  /// **'No locations found for your search'**
  String get setLocationNoResults;

  /// No description provided for @setLocationSelectError.
  ///
  /// In en, this message translates to:
  /// **'Please select a location to continue'**
  String get setLocationSelectError;

  /// No description provided for @setLocationSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save location. Please try again.'**
  String get setLocationSaveError;

  /// No description provided for @setLocationNavigationError.
  ///
  /// In en, this message translates to:
  /// **'Navigation failed. Please try again.'**
  String get setLocationNavigationError;

  /// No description provided for @setLocationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Select location'**
  String get setLocationPageTitle;

  /// No description provided for @setLocationPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use current location or search your own\nlocation'**
  String get setLocationPageSubtitle;

  /// No description provided for @setLocationEmptySearchError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a location'**
  String get setLocationEmptySearchError;

  /// No description provided for @setLocationSearchTooShortError.
  ///
  /// In en, this message translates to:
  /// **'Location search requires at least 3 characters'**
  String get setLocationSearchTooShortError;

  /// No description provided for @setLocationSearchTooLongError.
  ///
  /// In en, this message translates to:
  /// **'Location search cannot exceed 100 characters'**
  String get setLocationSearchTooLongError;

  /// No description provided for @setLocationInvalidSearchError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid location'**
  String get setLocationInvalidSearchError;

  /// No description provided for @categoriesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesPageTitle;

  /// No description provided for @categoriesLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading categories...'**
  String get categoriesLoadingMessage;

  /// No description provided for @categoriesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load categories'**
  String get categoriesLoadError;

  /// No description provided for @categoriesRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get categoriesRetryButton;

  /// No description provided for @categoriesNoDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get categoriesNoDataMessage;

  /// No description provided for @categoriesLoadMoreButton.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get categoriesLoadMoreButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ta'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ta':
      return AppLocalizationsTa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
