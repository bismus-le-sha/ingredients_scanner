import 'package:shared_preferences/shared_preferences.dart';

class ProductPreferences {
  ProductPreferences._shared(final SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  static ProductPreferences? _instance;
  final SharedPreferences _sharedPreferences;

  static Future<ProductPreferences> getProductPreferences() async {
    if (_instance == null) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      _instance = ProductPreferences._shared(preferences);
    }
    return _instance!;
  }

  static const String _TAG_SHUGAR_FREEE = 'shugar_free';
  static const String _TAG_LACTOSE_FREE = 'lactose_free';
  static const String _TAG_GLUTEN_FREE = 'gluten_free';
  static const String _TAG_WITHOUT_NUTS = 'without_nuts';
  static const String _TAG_WITHOUT_PEANUTS = 'without_peanuts';
  static const String _TAG_WITHOUT_SOYBEANS = 'without_soybeans';

  Future<void> setShugarFree(bool cameraFlash) async {
    await _sharedPreferences.setBool(_TAG_SHUGAR_FREEE, cameraFlash);
  }

  bool getShugarFree() =>
      _sharedPreferences.getBool(_TAG_SHUGAR_FREEE) ?? false;

  Future<void> setLactoseFree(bool cameraFlash) async {
    await _sharedPreferences.setBool(_TAG_LACTOSE_FREE, cameraFlash);
  }

  bool getLactoseFree() =>
      _sharedPreferences.getBool(_TAG_LACTOSE_FREE) ?? false;

  Future<void> setGlutenFree(bool cameraFlash) async {
    await _sharedPreferences.setBool(_TAG_GLUTEN_FREE, cameraFlash);
  }

  bool getGlutenFree() => _sharedPreferences.getBool(_TAG_GLUTEN_FREE) ?? false;

  Future<void> setWithoutNuts(bool cameraFlash) async {
    await _sharedPreferences.setBool(_TAG_WITHOUT_NUTS, cameraFlash);
  }

  bool getWithoutNutsh() =>
      _sharedPreferences.getBool(_TAG_WITHOUT_NUTS) ?? false;

  Future<void> setWithoutPeauts(bool cameraFlash) async {
    await _sharedPreferences.setBool(_TAG_WITHOUT_PEANUTS, cameraFlash);
  }

  bool getWithoutPeauts() =>
      _sharedPreferences.getBool(_TAG_WITHOUT_PEANUTS) ?? false;

  Future<void> setWithoutSoybeans(bool cameraFlash) async {
    await _sharedPreferences.setBool(_TAG_WITHOUT_SOYBEANS, cameraFlash);
  }

  bool getWithoutSoybeans() =>
      _sharedPreferences.getBool(_TAG_WITHOUT_SOYBEANS) ?? false;
}
