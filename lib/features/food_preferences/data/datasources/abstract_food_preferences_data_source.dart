import 'package:dartz/dartz.dart';

import '../models/food_preferences_model.dart';

abstract class FoodPreferencesDataSource {
  Future<FoodPreferencesModel> getFoodPreferences();
  Future<Unit> updateFoodPreferences(FoodPreferencesModel foodPreferencesModel);
}
