import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';

import '../abstract_food_preferences_data_source.dart';

class RemoteFoodPreferencesDataSource implements FoodPreferencesDataSource {
  //TODO: need to write code for firebase remote datasource
  @override
  Future<FoodPreferencesModel> getFoodPreferences() {
    // TODO: implement getFoodPreference
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateFoodPreferences(
      FoodPreferencesModel foodPreferencesModel) {
    // TODO: implement setFoodPreference
    throw UnimplementedError();
  }
}
