import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  UserPreferences._shared(final SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  static UserPreferences? _instance;
  final SharedPreferences _sharedPreferences;

  static Future<UserPreferences> getUserPreferences() async {
    if (_instance == null) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      _instance = UserPreferences._shared(preferences);
    }
    return _instance!;
  }

  static const _cameraFlash = 'camera_flash';
  static const _rememberMe = 'remember_me';
  static const _authenticated = 'authenticated';
  // static const _rememberMe = 'remember_me';

  Future<void> setCameraFlash(bool cameraFlash) async {
    await _sharedPreferences.setBool(_cameraFlash, cameraFlash);
  }

  bool getCameraFlash() => _sharedPreferences.getBool(_cameraFlash) ?? false;

  Future<void> setRememberMe(bool rememberMe) async {
    await _sharedPreferences.setBool(_rememberMe, rememberMe);
  }

  bool? getRememberMe() => _sharedPreferences.getBool(_rememberMe) ?? false;

  Future<void> setAuthenticated(bool authenticated) async {
    await _sharedPreferences.setBool(_authenticated, authenticated);
  }

  bool? getAuthenticated() =>
      _sharedPreferences.getBool(_authenticated) ?? false;
}
