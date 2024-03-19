import 'package:dartz/dartz.dart';

import '../models/user_preferences_model.dart';

abstract class UserPreferencesAbstractDataSource {
  Future<UserPreferencesModel> getUserPreferences();
  Future<Unit> setUserPreferences(UserPreferencesModel userPreferencesModel);
}
