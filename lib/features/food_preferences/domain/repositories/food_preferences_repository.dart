import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';

abstract class FoodPreferencesRepository {
  Future<Either<Failure, FoodPreferencesEntity>> getFoodPreference();
  Future<Either<Failure, Unit>> setFoodPreference(
      FoodPreferencesModel foodPreferencesModel);
}
