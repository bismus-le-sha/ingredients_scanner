import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/usecases/params/food_preferences_params.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/usecases/update_food_preferences.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UpdateFoodPreference usecase;
  late MockFoodPreferencesRepository repository;

  setUp(() => {
        repository = MockFoodPreferencesRepository(),
        usecase = UpdateFoodPreference(repository)
      });

  const testFoodPreference = FoodPreferencesModel(
      sugarFree: true,
      lactoseFree: false,
      glutenFree: false,
      withoutSoybeans: false,
      withoutNuts: false,
      withoutPeanuts: false,
      version: 1);

  test('should get food preferences from the repository', () async {
    //arrange
    when(repository.updateFoodPreference(testFoodPreference))
        .thenAnswer((_) async => const Right(unit));
    //act
    final result = await usecase.call(
        const FoodPreferencesParams(foodPreferencesModel: testFoodPreference));
    //assert
    expect(result, const Right(unit));
    verify(repository.updateFoodPreference(testFoodPreference));
    verifyNoMoreInteractions(repository);
  });
}
