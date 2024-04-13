import 'package:dartz/dartz.dart';

import '../../models/food_preferences_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalFoodPreferencesDataSource {
  Future<FoodPreferencesModel> getFoodPreferences();
  Future<Unit> updateFoodPreferences(FoodPreferencesModel foodPreferencesModel);
}

class LocalFoodPreferencesDataSourceImpl
    implements LocalFoodPreferencesDataSource {
  final SharedPreferences sharedPreferences;

  LocalFoodPreferencesDataSourceImpl({required this.sharedPreferences});

  @override
  Future<FoodPreferencesModel> getFoodPreferences() {
    return Future.value(
        FoodPreferencesModel.fromSharedPreferences(sharedPreferences));
  }

  @override
  Future<Unit> updateFoodPreferences(
      FoodPreferencesModel foodPreferencesModel) {
    foodPreferencesModel.toSharedPreferences(sharedPreferences);
    return Future.value(unit);
  }
}
