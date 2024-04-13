import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/food_preferences_model.dart';
import '../entities/food_preferences_entity.dart';

abstract class FoodPreferencesRepository {
  Future<Either<Failure, FoodPreferencesEntity>> getFoodPreference();
  Future<Either<Failure, Unit>> updateFoodPreference(
      FoodPreferencesModel foodPreferencesModel);
}
