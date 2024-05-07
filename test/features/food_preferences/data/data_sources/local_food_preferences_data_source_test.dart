import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/resources/food_preferences_list.dart';
import 'package:ingredients_scanner/features/food_preferences/data/datasources/local/local_food_preferences_data_source.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockSharedPreferences preferences;
  late LocalFoodPreferencesDataSourceImpl localDataSource;
  late FoodPreferencesModel testFoodPreferencesModel;

  setUp(() {
    preferences = MockSharedPreferences();
    localDataSource =
        LocalFoodPreferencesDataSourceImpl(sharedPreferences: preferences);
    testFoodPreferencesModel = FoodPreferencesModel.fromJson(
        const JsonDecoder().convert(fixture('food_preferences.json')));
  });

  group('getFoodPreferences', () {
    test('should return FoodPreferences from SharedPreferences', () async {
      //arrange
      when(preferences.getBool(SUGAR_FREE)).thenReturn(true);
      when(preferences.getBool(LACTOSE_FREE)).thenReturn(false);
      when(preferences.getBool(GLUTEN_FREE)).thenReturn(false);
      when(preferences.getBool(WITHOUT_NUTS)).thenReturn(false);
      when(preferences.getBool(WITHOUT_PEANUTS)).thenReturn(false);
      when(preferences.getBool(WITHOUT_SOYBEANS)).thenReturn(false);
      when(preferences.getInt(VERSION)).thenReturn(1);

      //act
      final result = await localDataSource.getFoodPreferences();
      //assert
      expect(result, equals(testFoodPreferencesModel));
    });
  });

  group('updateFoodPrefernces', () {
    test('should update FoodPreferences in SharedPreferences', () async {
      //arrange
      when(preferences.setBool(any, any)).thenAnswer((_) async => true);
      when(preferences.setInt(any, any)).thenAnswer((_) async => true);
      //act
      localDataSource.updateFoodPreferences(testFoodPreferencesModel);
      //assert
      verify(preferences.setBool(
              SUGAR_FREE, testFoodPreferencesModel.sugarFree))
          .called(1);
      verify(preferences.setBool(
              LACTOSE_FREE, testFoodPreferencesModel.lactoseFree))
          .called(1);
      verify(preferences.setBool(
              GLUTEN_FREE, testFoodPreferencesModel.glutenFree))
          .called(1);
      verify(preferences.setBool(
              WITHOUT_NUTS, testFoodPreferencesModel.withoutNuts))
          .called(1);
      verify(preferences.setBool(
              WITHOUT_PEANUTS, testFoodPreferencesModel.withoutPeanuts))
          .called(1);
      verify(preferences.setBool(
              WITHOUT_SOYBEANS, testFoodPreferencesModel.withoutSoybeans))
          .called(1);
      verify(preferences.setInt(VERSION, testFoodPreferencesModel.version))
          .called(1);
    });
  });
}
