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
  static const _useBiometrics = 'use_biometrics';
  static const _showAskBiometrics = 'show_ask_biometrics';

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

  Future<void> setUseBiometrics(bool useBiometrics) async {
    await _sharedPreferences.setBool(_useBiometrics, useBiometrics);
  }

  bool? getUseBiometrics() =>
      _sharedPreferences.getBool(_useBiometrics) ?? false;

  Future<void> setShowAskBiometrics(bool showAskBiometrics) async {
    await _sharedPreferences.setBool(_showAskBiometrics, showAskBiometrics);
  }

  bool? getShowAskBiometrics() =>
      _sharedPreferences.getBool(_showAskBiometrics) ?? true;
}
