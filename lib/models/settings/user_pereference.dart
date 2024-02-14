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

  // static const String _TAG_INIT = 'init';
  static const _cameraFlash = 'camera_flash';
  static const _rememberMe = 'remember_me';

  // Future<void> init(final ProductPreferences productPreferences) async {
  //   if (_sharedPreferences.getBool(_TAG_INIT) != null) {
  //     return;
  //   }
  //   await productPreferences.resetImportances();
  //   await _sharedPreferences.setBool(_TAG_INIT, true);
  // }

  Future<void> setCameraFlash(bool cameraFlash) async {
    await _sharedPreferences.setBool(_cameraFlash, cameraFlash);
  }

  bool getCameraFlash() => _sharedPreferences.getBool(_cameraFlash) ?? false;

  Future<void> setRememberMe(bool rememberMe) async {
    await _sharedPreferences.setBool(_rememberMe, rememberMe);
  }

  bool? getRememberMe() => _sharedPreferences.getBool(_rememberMe) ?? false;
}
