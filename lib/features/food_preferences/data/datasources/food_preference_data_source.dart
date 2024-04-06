import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';

abstract class FoodPreferencesDataSource {
  Future<FoodPreferencesModel> getFoodPreference();
  Future<Unit> setFoodPreference(FoodPreferencesModel foodPreferencesModel);
}

class RemoteFoodPreferencesDataSource implements FoodPreferencesDataSource {
  @override
  Future<FoodPreferencesModel> getFoodPreference() {
    // TODO: implement getFoodPreference
    throw UnimplementedError();
  }

  @override
  Future<Unit> setFoodPreference(FoodPreferencesModel foodPreferencesModel) {
    // TODO: implement setFoodPreference
    throw UnimplementedError();
  }
}
