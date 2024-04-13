import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/strings/food_preferences_list.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences preferences;

  setUp(() {
    preferences = MockSharedPreferences();
  });

  const testFoodPreferencesModel = FoodPreferencesModel(
      sugarFree: true,
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
        "sugarFree": true,
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

  group('from/toSharedPreferences', () {
    test('should return a valid model from SharedPreferences', () async {
      //arrange
      when(preferences.getBool(SUGAR_FREE)).thenReturn(true);
      when(preferences.getBool(LACTOSE_FREE)).thenReturn(false);
      when(preferences.getBool(GLUTEN_FREE)).thenReturn(false);
      when(preferences.getBool(WITHOUT_NUTS)).thenReturn(false);
      when(preferences.getBool(WITHOUT_PEANUTS)).thenReturn(false);
      when(preferences.getBool(WITHOUT_SOYBEANS)).thenReturn(false);
      when(preferences.getInt(VERSION)).thenReturn(1);
      //act
      final result = FoodPreferencesModel.fromSharedPreferences(preferences);
      //assert
      expect(result, testFoodPreferencesModel);
    });

    test('should set SharedPreferences correctly', () async {
      //arrange
      when(preferences.setBool(SUGAR_FREE, true))
          .thenAnswer(((_) => Future.value(true)));
      when(preferences.setBool(LACTOSE_FREE, false))
          .thenAnswer(((_) => Future.value(false)));
      when(preferences.setBool(GLUTEN_FREE, false))
          .thenAnswer(((_) => Future.value(false)));
      when(preferences.setBool(WITHOUT_NUTS, false))
          .thenAnswer(((_) => Future.value(false)));
      when(preferences.setBool(WITHOUT_PEANUTS, false))
          .thenAnswer(((_) => Future.value(false)));
      when(preferences.setBool(WITHOUT_SOYBEANS, false))
          .thenAnswer(((_) => Future.value(false)));
      when(preferences.setInt(VERSION, 1))
          .thenAnswer(((_) => Future.value(false)));
      //act
      testFoodPreferencesModel.toSharedPreferences(preferences);
      //assert
      verify(preferences.setBool(SUGAR_FREE, true));
      verify(preferences.setBool(LACTOSE_FREE, false));
      verify(preferences.setBool(GLUTEN_FREE, false));
      verify(preferences.setBool(WITHOUT_NUTS, false));
      verify(preferences.setBool(WITHOUT_PEANUTS, false));
      verify(preferences.setBool(WITHOUT_SOYBEANS, false));
      verify(preferences.setInt(VERSION, 1));
    });
  });
}
