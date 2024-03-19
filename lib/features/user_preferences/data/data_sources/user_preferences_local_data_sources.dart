import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_preferences_model.dart';
import 'user_preferences_abstract_data_source.dart';

abstract class UserPreferencesLocalDataSource
    extends UserPreferencesAbstractDataSource {}

class UserPreferencesLocalDataSourceImpl
    implements UserPreferencesLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserPreferencesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserPreferencesModel> getUserPreferences() {
    // TODO: implement getUserPreferences
    throw UnimplementedError();
  }

  @override
  Future<Unit> setUserPreferences(UserPreferencesModel userPreferencesModel) {
    // TODO: implement setUserPreferences
    throw UnimplementedError();
  }
}
