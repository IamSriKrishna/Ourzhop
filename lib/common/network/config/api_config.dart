class ApiConfig {
  ApiConfig._();

  static const String baseUrl = "https://api.crispyminds.com/api/v1";
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static const String login = '/login';
  static const String otpVerify = '/verify-otp';
  static const String accountSetup = '/users/profile';


  static const String categories = '/categories';
  static const String shopsLocation = '/shops/location';
  static const String searchApi = '/search/places/autocomplete';
  static const String searchAutocomplete = '/search/autocomplete';

  static const String shops = '/shops';


  static const Map<String, String> header = <String, String>{
    'content-Type': 'application/json',
  };
}
