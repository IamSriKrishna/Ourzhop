// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:customer_app/features/auth/data/models/user_model.dart';

class AuthPreferenceService {
  static const _boxName = 'userPreferences';
  static const _isLoggedInKey = 'isLoggedIn';
  static const String _userKey = 'userData';
  static const String _hasSelectedLocationKey = 'hasSelectedLocation';
  static const String _userLocationKey = 'userLocation';

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

  Future<void> updateUserProfileInfo({
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

  /// Location selection methods
  Future<void> setLocationSelected(bool value) async {
    final box = await Hive.openBox(_boxName);
    await box.put(_hasSelectedLocationKey, value);
  }

  Future<void> saveUserLocation(String location) async {
    final currentUser = await getUser();
    if (currentUser != null) {
      final updatedUser = UserModel(
        mobileNumber: currentUser.mobileNumber,
        role: currentUser.role,
        token: currentUser.token,
        isNewUser: currentUser.isNewUser,
        name: currentUser.name,
        email: currentUser.email,
        location: location, // Set the location
      );
      await saveUser(updatedUser);
    }
  }

  Future<bool> hasSelectedLocation() async {
    final currentUser = await getUser();
    // Check both the user model location AND the separate flag
    final hasLocationInUser =
        currentUser?.location != null && currentUser!.location!.isNotEmpty;

    // Also check the separate flag if you're using it
    var box = await Hive.openBox(_boxName);
    final hasLocationFlag =
        box.get(_hasSelectedLocationKey, defaultValue: false);

    return hasLocationInUser || hasLocationFlag;
  }

  Future<String?> getUserLocation() async {
    final currentUser = await getUser();
    return currentUser?.location;
  }

  /// Clears stored user data and logged in flag upon logout.
  Future<void> logout() async {
    final box = await Hive.openBox(_boxName);
    await box.delete(_isLoggedInKey);
    await box.delete(_userKey);
    await box.delete(_hasSelectedLocationKey);
    await box.delete(_userLocationKey);
  }
}
