import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';

import 'user_preferences_abstract_data_source.dart';

abstract class UserPreferencesRemoteDataSource
    extends UserPreferencesAbstractDataSource {}

class UserPreferencesRemoteDataSourceImpl
    implements UserPreferencesRemoteDataSource {
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
