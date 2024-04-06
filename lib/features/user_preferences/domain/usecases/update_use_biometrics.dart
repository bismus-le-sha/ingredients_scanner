import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_preferences_repositiory.dart';
import 'params/user_preferences_params.dart';

class UpdateUseBiometrics implements UseCase<Unit, UserPreferencesParams> {
  final UserPreferencesRepository repository;

  UpdateUseBiometrics(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UserPreferencesParams params) async {
    return await repository.updateUseBiometrics(params.value);
  }
}
