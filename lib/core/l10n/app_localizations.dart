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
  /// **'Didn’t get OTP Code ?'**
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

  /// No description provided for @bottomNavHubs.
  ///
  /// In en, this message translates to:
  /// **'Hubs'**
  String get bottomNavHubs;

  /// No description provided for @bottomNavCars.
  ///
  /// In en, this message translates to:
  /// **'Cars'**
  String get bottomNavCars;

  /// No description provided for @bottomNavUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get bottomNavUsers;

  /// No description provided for @bottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get bottomNavProfile;

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
