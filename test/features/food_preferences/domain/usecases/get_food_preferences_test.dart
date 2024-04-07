import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/usecases/get_food_preferences_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GetFoodPreference usecase;
  late MockFoodPreferencesRepository repository;

  setUp(() => {
        repository = MockFoodPreferencesRepository(),
        usecase = GetFoodPreference(repository)
      });

  const foodPreference = FoodPreferencesEntity(
      sugarFree: true,
      lactoseFree: false,
      glutenFree: false,
      withoutSoybeans: false,
      withoutNuts: false,
      withoutPeanuts: false,
      version: 1);

  test('should get food preferences from the repository', () async {
    //arrange
    when(repository.getFoodPreference())
        .thenAnswer((_) async => const Right(foodPreference));
    //act
    final result = await usecase.call(NoParams());
    //assert
    expect(result, const Right(foodPreference));
  });
}
