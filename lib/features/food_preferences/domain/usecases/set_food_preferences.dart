import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/repositories/food_preferences_repository.dart';

import 'params/food_preferences_params.dart';

class SetFoodPreference implements UseCase<Unit, FoodPreferencesParams> {
  final FoodPreferencesRepository repository;

  SetFoodPreference(this.repository);

  @override
  Future<Either<Failure, Unit>> call(FoodPreferencesParams params) async {
    return await repository.setFoodPreference(params.foodPreferencesModel);
  }
}
