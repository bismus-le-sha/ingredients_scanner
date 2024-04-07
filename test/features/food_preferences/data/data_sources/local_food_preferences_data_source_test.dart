import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/food_preferences/data/datasources/local/local_food_preferences_data_source.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockBox box;
  late LocalFoodPreferencesDataSource localDataSource;
  late FoodPreferencesModel testFoodPreferencesModel;

  setUp(() {
    box = MockBox();
    localDataSource = LocalFoodPreferencesDataSource(foodPreferencesBox: box);
    testFoodPreferencesModel = FoodPreferencesModel.fromJson(
        const JsonDecoder().convert(fixture('food_preferences.json')));
  });

  group('getFoodPreferences', () {
    test('should return FoodPreferences from Hive', () async {
      //arrange
      when(box.get(any)).thenReturn(
          const JsonDecoder().convert(fixture('food_preferences.json')));
      //act
      final result = await localDataSource.getFoodPreferences();
      //assert
      verify(box.get(idFoodPreferences));
      expect(result, equals(testFoodPreferencesModel));
    });
  });

  group('updateFoodPrefernces', () {
    test('should update FoodPreferences in Hive', () async {
      //arrange
      when(box.put(any, testFoodPreferencesModel))
          .thenAnswer((_) async => unit);
      //act
      final result =
          await localDataSource.updateFoodPreferences(testFoodPreferencesModel);
      //assert
      verify(box.put(idFoodPreferences, testFoodPreferencesModel.toJson()));
      expect(result, unit);
    });
  });
}
