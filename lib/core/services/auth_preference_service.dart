// Package imports:

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:customer_app/features/auth/data/models/user_model.dart';

class AuthPreferenceService {
  static const _boxName = 'userPreferences';
  static const _isLoggedInKey = 'isLoggedIn';
  static const String _userKey = 'userData';

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

  /// Clears stored user data and logged in flag upon logout.
  Future<void> logout() async {
    final box = await Hive.openBox(_boxName);
    await box.delete(_isLoggedInKey);
    await box.delete(_userKey);
  }
}
