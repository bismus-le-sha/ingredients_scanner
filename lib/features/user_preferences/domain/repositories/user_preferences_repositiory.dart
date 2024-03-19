import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_preferences.dart';

abstract class UserPreferencesRepository {
  Future<Either<Failure, UserPreferencesEntity>> getUserPreferences();
  Future<Either<Failure, Unit>> setUserPreferences(
      UserPreferencesModel userPreferencesModel);
}
