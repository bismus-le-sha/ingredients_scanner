import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_preferences_model.dart';

abstract class UserPreferencesDataSource {
  Future<UserPreferencesModel> getUserPreferences();
  Future<Unit> updateCameraFlash(bool value);
  Future<Unit> updateUseBiometrics(bool value);
}

const cameraFlash = 'cameraFlash';
const useBiometrics = 'useBiometrics';

class UserPreferencesDataSourceImpl implements UserPreferencesDataSource {
  final SharedPreferences sharedPreferences;

  UserPreferencesDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserPreferencesModel> getUserPreferences() {
    return Future.value(
        UserPreferencesModel.fromSharedPreferences(sharedPreferences));
  }

  @override
  Future<Unit> updateCameraFlash(bool value) {
    sharedPreferences.setBool(cameraFlash, value);
    return Future.value(unit);
  }

  @override
  Future<Unit> updateUseBiometrics(bool value) {
    sharedPreferences.setBool(useBiometrics, value);
    return Future.value(unit);
  }
}
