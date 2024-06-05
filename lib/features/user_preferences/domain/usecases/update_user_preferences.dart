import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_preferences_repositiory.dart';
import 'params/user_preferences_params.dart';

class UpdateUserPreferences implements UseCase<Unit, UserPreferencesParams> {
  final UserPreferencesRepository repository;

  UpdateUserPreferences(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UserPreferencesParams params) async {
    return await repository.updateUserPreferences(params.userPreferences);
  }
}
