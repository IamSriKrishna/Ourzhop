// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:customer_app/core/models/stored_location_model.dart';
import 'package:customer_app/core/models/user_model.dart';

class UserPreferenceService {
  static const _boxName = 'customer_app_preferences';
  static const _isLoggedInKey = 'isLoggedIn';
  static const String _userKey = 'userData';
  static const String _storedLocationKey = 'storedLocationData';

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox(_boxName);
    return box.get(_isLoggedInKey, defaultValue: false);
  }

  Future<void> setLoggedIn(bool loggedIn) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_isLoggedInKey, loggedIn);
  }

  Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_userKey, user.toJson());
  }

  Future<UserModel?> getUser() async {
    final box = await Hive.openBox(_boxName);
    final userJson = box.get(_userKey);

    if (userJson != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userJson));
    } else {
      return null;
    }
  }

  Future<void> updateProfileUserInfo({
    required String name,
    required String email,
    required bool isNewUser,
  }) async {
    final currentUser = await getUser();

    if (currentUser != null) {
      final updatedUser = UserModel(
        name: name,
        email: email,
        mobileNumber: currentUser.mobileNumber,
        role: currentUser.role,
        token: currentUser.token,
        isNewUser: isNewUser,
      );
      await saveUser(updatedUser);
    }
  }

  Future<void> markUserAsExisting() async {
    final currentUser = await getUser();
    if (currentUser != null) {
      final updatedUser = UserModel(
        name: currentUser.name,
        email: currentUser.email,
        mobileNumber: currentUser.mobileNumber,
        role: currentUser.role,
        token: currentUser.token,
        isNewUser: false,
      );
      await saveUser(updatedUser);
    }
  }

  Future<bool> isUserNew() async {
    final currentUser = await getUser();
    if (currentUser != null) {
      return currentUser.isNewUser;
    } else {
      return false;
    }
  }

  // Location methods - Simple implementation with single source of truth

  /// Saves complete location data with coordinates and display text
  Future<void> saveSelectedLocation(StoredLocationModel location) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_storedLocationKey, location.toJson());
  }

  /// Gets location coordinates if available
  /// Returns Map with 'latitude' and 'longitude' keys
  Future<Map<String, double>?> getLocationCoordinates() async {
    final storedLocation = await getSelectedLocation();
    if (storedLocation != null) {
      return {
        'latitude': storedLocation.latitude,
        'longitude': storedLocation.longitude,
      };
    }
    return null;
  }

  /// Gets main display text for the location
  Future<String?> getLocationMainText() async {
    final storedLocation = await getSelectedLocation();
    return storedLocation?.mainText;
  }

  /// Retrieves complete stored location data
  Future<StoredLocationModel?> getSelectedLocation() async {
    final box = await Hive.openBox(_boxName);
    final locationJson = box.get(_storedLocationKey);

    if (locationJson != null) {
      return StoredLocationModel.fromJson(
          Map<String, dynamic>.from(locationJson));
    }
    return null;
  }

  /// Clears location data from storage
  Future<void> clearLocationData() async {
    final box = await Hive.openBox(_boxName);
    await box.delete(_storedLocationKey);
  }

  /// Checks if location data is available
  Future<bool> isLocationAvailable() async {
    final storedLocation = await getSelectedLocation();
    return storedLocation != null;
  }

  /// Clears stored user data and logged in flag upon logout.
  Future<void> logout() async {
    final box = await Hive.openBox(_boxName);
    await box.delete(_isLoggedInKey);
    await box.delete(_userKey);
    await box.delete(_storedLocationKey);
  }
}
