import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_preferences_repositiory.dart';
import 'params/user_preferences_params.dart';

class SetUserPreferences implements UseCase<Unit, UserPreferencesParams> {
  final UserPreferencesRepository repository;

  SetUserPreferences(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UserPreferencesParams params) async {
    return await repository.setUserPreferences(params.userPreferencesEntity);
  }
}
