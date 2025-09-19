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
  String get loginScreenTitle => 'Login';

  @override
  String get loginScreenSubtitle => 'Enter your mobile number';

  @override
  String get mobileNumberLabel => 'Mobile Number';

  @override
  String get verifyButtonTitle => 'Verify';

  @override
  String get generatingOtpTitle => 'Generating OTP...';

  @override
  String get loginErrorTitle => 'Login Error';

  @override
  String get phoneNumberValidationError =>
      'Please enter a valid 10-digit mobile number';

  @override
  String get phoneNumberRequired => 'Phone number is required';

  @override
  String get phoneNumberTooShort => 'Phone number must be exactly 10 digits';

  @override
  String get phoneNumberTooLong => 'Phone number must be exactly 10 digits';

  @override
  String get phoneNumberInvalid => 'Phone number must contain only digits';

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
  String get verifyOtpDidNotReceiveOtp => 'Didn\'t get OTP Code ?';

  @override
  String get verifyOtpResendCode => 'Resend Code';

  @override
  String get verifyOtpProgressVerifying => 'Verifying OTP...';

  @override
  String get otpTitle => 'OTP';

  @override
  String get otpSubtitle => 'Enter the OTP sent to your number';

  @override
  String get resendButtonTitle => 'Resend';

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
  String get accountSetupNameRequired => 'Name is required';

  @override
  String get accountSetupEmailRequired => 'Email is required';

  @override
  String get accountSetupEmailInvalid => 'Please enter a valid email address';

  @override
  String get nameValidationEmpty => 'Name is required';

  @override
  String get nameValidationTooShort => 'Name must be at least 2 characters';

  @override
  String get nameValidationTooLong => 'Name must be less than 50 characters';

  @override
  String get nameValidationInvalid => 'Name contains invalid characters';

  @override
  String get emailValidationEmpty => 'Email is required';

  @override
  String get emailValidationInvalid => 'Please enter a valid email address';

  @override
  String get emailValidationTooLong => 'Email is too long';

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
  String get bottomNavHome => 'Home';

  @override
  String get bottomNavCategories => 'Categories';

  @override
  String get bottomNavCart => 'Cart';

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

  @override
  String get gettingLocationTitle => 'Getting your location...';

  @override
  String get selectLocationTitle => 'Select location';

  @override
  String get selectLocationSubtitle =>
      'Use current location or search your own\nlocation';

  @override
  String get noLocationsFound => 'No locations found for your search';

  @override
  String get searchLocationHint => 'Search for area, street...';

  @override
  String get useCurrentLocation => 'Use current location';

  @override
  String get locationDetected => 'Location detected';

  @override
  String get locationPermissionNeeded => 'Need to give location permission';

  @override
  String get continueButtonTitle => 'Continue';

  @override
  String get locationPermissionRequired =>
      'Location permission is required to get your current location';

  @override
  String get setLocationTitle => 'Set Your Location';

  @override
  String get setLocationSubtitle => 'Search and select your preferred location';

  @override
  String get setLocationSearchHint => 'Search for area, street...';

  @override
  String get setLocationNoResults => 'No locations found for your search';

  @override
  String get setLocationSelectError => 'Please select a location to continue';

  @override
  String get setLocationSaveError =>
      'Failed to save location. Please try again.';

  @override
  String get setLocationNavigationError =>
      'Navigation failed. Please try again.';

  @override
  String get setLocationPageTitle => 'Select location';

  @override
  String get setLocationPageSubtitle =>
      'Use current location or search your own\nlocation';

  @override
  String get setLocationEmptySearchError => 'Please enter a location';

  @override
  String get setLocationSearchTooShortError =>
      'Location search requires at least 3 characters';

  @override
  String get setLocationSearchTooLongError =>
      'Location search cannot exceed 100 characters';

  @override
  String get setLocationInvalidSearchError => 'Please enter a valid location';

  @override
  String get categoriesPageTitle => 'Categories';

  @override
  String get categoriesLoadingMessage => 'Loading categories...';

  @override
  String get categoriesLoadError => 'Failed to load categories';

  @override
  String get categoriesRetryButton => 'Retry';

  @override
  String get categoriesNoDataMessage => 'No categories available';

  @override
  String get categoriesLoadMoreButton => 'Load More';
}
