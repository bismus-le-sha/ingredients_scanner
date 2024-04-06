import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_preferences_entity.dart';

abstract class UserPreferencesRepository {
  Future<Either<Failure, UserPreferencesEntity>> getUserPreferences();
  Future<Either<Failure, Unit>> updateCameraFlash(bool value);
  Future<Either<Failure, Unit>> updateUseBiometrics(bool value);
}
