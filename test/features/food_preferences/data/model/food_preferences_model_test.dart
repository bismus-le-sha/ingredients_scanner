import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testFoodPreferencesModel = FoodPreferencesModel(
      shugarFree: true,
      lactoseFree: false,
      glutenFree: false,
      withoutSoybeans: false,
      withoutNuts: false,
      withoutPeanuts: false,
      version: 1);

  test('should be a subclass of food preference entity', () async {
    expect(testFoodPreferencesModel, isA<FoodPreferencesEntity>());
  });

  group('from/toJson', () {
    test('should return a valid modele from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('food_preferences.json'));
      //act
      final result = FoodPreferencesModel.fromJson(jsonMap);
      //assert
      expect(result, testFoodPreferencesModel);
    });

    test('should return JSON map containing the proper data', () async {
      //act
      final result = testFoodPreferencesModel.toJson();
      //assert
      final expectedMap = {
        "shugarFree": true,
        "lactoseFree": false,
        "glutenFree": false,
        "withoutNuts": false,
        "withoutPeanuts": false,
        "withoutSoybeans": false,
        "version": 1,
      };
      expect(result, expectedMap);
    });
  });
}
