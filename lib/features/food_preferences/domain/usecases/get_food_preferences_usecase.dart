import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/repositories/food_preferences_repository.dart';

class GetFoodPreference implements UseCase<FoodPreferencesEntity, NoParams> {
  final FoodPreferencesRepository repository;

  GetFoodPreference(this.repository);

  @override
  Future<Either<Failure, FoodPreferencesEntity>> call(NoParams params) async {
    return await repository.getFoodPreference();
  }
}
