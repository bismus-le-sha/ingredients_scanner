import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:ingredients_scanner/features/food_preferences/data/datasources/abstract_food_preferences_data_source.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';

const idFoodPreferences = 0;

class LocalFoodPreferencesDataSource implements FoodPreferencesDataSource {
  final Box foodPreferencesBox;

  LocalFoodPreferencesDataSource({required this.foodPreferencesBox});

  @override
  Future<FoodPreferencesModel> getFoodPreferences() {
    return Future.value(FoodPreferencesModel.fromJson(
        foodPreferencesBox.get(idFoodPreferences)));
  }

  @override
  Future<Unit> updateFoodPreferences(
      FoodPreferencesModel foodPreferencesModel) {
    foodPreferencesBox.put(idFoodPreferences, foodPreferencesModel.toJson());
    return Future.value(unit);
  }
}
