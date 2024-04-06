import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_preferences_entity.dart';

const CAMERA_FLASH = 'cameraFlash';
const USE_BIOMETRICS = 'useBiometrics';

class UserPreferencesModel extends UserPreferencesEntity {
  const UserPreferencesModel({
    required super.cameraFlash,
    required super.useBiometrics,
  });

  factory UserPreferencesModel.fromSharedPreferences(
      SharedPreferences preferences) {
    return UserPreferencesModel(
        cameraFlash: preferences.getBool(CAMERA_FLASH) ?? false,
        useBiometrics: preferences.getBool(USE_BIOMETRICS) ?? false);
  }

  void toSharedPreferences(SharedPreferences preferences) {
    preferences.setBool(CAMERA_FLASH, cameraFlash);
    preferences.setBool(USE_BIOMETRICS, useBiometrics);
  }
}
