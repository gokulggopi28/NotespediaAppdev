import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyIsVisited = 'is_visited';
  static const String _keyPhoneNumber = 'phone_number';
  static const String _keyEmail = 'email';
  static const String _keyUsername = 'username';
  static const String _keyUserId = 'user_id';
  static const String _keySubscriptionStatus = 'subscription_status';
  static const String _keyAuthToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';

  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> clearUserPreferences() async {
    await _preferences?.clear();
  }

  // Setter methods
  static Future<void> setIsLoggedIn(bool value) async =>
      _preferences?.setBool(_keyIsLoggedIn, value) ?? Future.value();
  static Future<void> setIsVisited(bool value) async =>
      _preferences?.setBool(_keyIsVisited, value) ?? Future.value();
  static Future<void> setPhoneNumber(String value) async =>
      _preferences?.setString(_keyPhoneNumber, value) ?? Future.value();
  static Future<void> setEmail(String value) async =>
      _preferences?.setString(_keyEmail, value) ?? Future.value();
  static Future<void> setUsername(String value) async =>
      _preferences?.setString(_keyUsername, value) ?? Future.value();
  static Future<void> setUserId(int value) async =>
      _preferences?.setInt(_keyUserId, value) ?? Future.value();
  static Future<void> setSubscriptionStatus(int value) async =>
      _preferences?.setInt(_keySubscriptionStatus, value) ?? Future.value();
  static Future<void> setAuthToken(String value) async =>
      _preferences?.setString(_keyAuthToken, value) ?? Future.value();
  static Future<void> setRefreshToken(String value) async =>
      _preferences?.setString(_keyRefreshToken, value) ?? Future.value();

  // Getter methods
  static bool get isLoggedIn => _preferences?.getBool(_keyIsLoggedIn) ?? false;
  static bool get isVisited => _preferences?.getBool(_keyIsVisited) ?? false;
  static String get phoneNumber =>
      _preferences?.getString(_keyPhoneNumber) ?? '';
  static String get email => _preferences?.getString(_keyEmail) ?? '';
  static String get username => _preferences?.getString(_keyUsername) ?? '';
  static int get userId => _preferences?.getInt(_keyUserId) ?? 0;
  static int get subscriptionStatus =>
      _preferences?.getInt(_keySubscriptionStatus) ?? 0;
  static String get authToken => _preferences?.getString(_keyAuthToken) ?? '';
  static String get refreshToken =>
      _preferences?.getString(_keyRefreshToken) ?? '';
}
