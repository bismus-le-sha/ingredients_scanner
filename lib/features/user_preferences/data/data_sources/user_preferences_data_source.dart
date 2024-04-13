import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_preferences_model.dart';

abstract class UserPreferencesDataSource {
  Future<UserPreferencesModel> getUserPreferences();
  Future<Unit> updateUserPreferences(UserPreferencesModel userPreferencesModel);
}
class UserPreferencesDataSourceImpl implements UserPreferencesDataSource {
  final SharedPreferences sharedPreferences;

  UserPreferencesDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserPreferencesModel> getUserPreferences() {
    return Future.value(
        UserPreferencesModel.fromSharedPreferences(sharedPreferences));
  }

  @override
  Future<Unit> updateUserPreferences(
      UserPreferencesModel userPreferencesModel) {
    userPreferencesModel.toSharedPreferences(sharedPreferences);
    return Future.value(unit);
  }
}
