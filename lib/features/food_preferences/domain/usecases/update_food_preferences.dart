import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/food_preferences_repository.dart';

import 'params/food_preferences_params.dart';

class UpdateFoodPreferences implements UseCase<Unit, FoodPreferencesParams> {
  final FoodPreferencesRepository repository;

  UpdateFoodPreferences(this.repository);

  @override
  Future<Either<Failure, Unit>> call(FoodPreferencesParams params) async {
    return await repository.updateFoodPreference(params.foodPreferencesModel);
  }
}
