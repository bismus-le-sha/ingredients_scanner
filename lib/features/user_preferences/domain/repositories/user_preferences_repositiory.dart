import 'package:dartz/dartz.dart';
import '../../data/models/user_preferences_model.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_preferences_entity.dart';

abstract class UserPreferencesRepository {
  Future<Either<Failure, UserPreferencesEntity>> getUserPreferences();
  Future<Either<Failure, Unit>> updateUserPreferences(
      UserPreferencesModel userPreferencesModel);
}
