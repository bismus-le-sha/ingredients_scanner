import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_preferences.dart';
import '../repositories/user_preferences_repositiory.dart';

class GetUserPreferences implements UseCase<UserPreferencesEntity, NoParams> {
  final UserPreferencesRepository repository;

  GetUserPreferences(this.repository);

  @override
  Future<Either<Failure, UserPreferencesEntity>> call(NoParams params) async {
    return await repository.getUserPreferences();
  }
}
