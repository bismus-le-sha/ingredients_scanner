import 'dart:async';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/usecases/params/food_preferences_params.dart';
import 'package:ingredients_scanner/features/food_preferences/presentation/bloc/food_preferences_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late FoodPreferencesBloc bloc;
  late MockGetFoodPreferences getFoodPreferences;
  late MockUpdateFoodPreferences updateFoodPreferences;

  setUp(() {
    getFoodPreferences = MockGetFoodPreferences();
    updateFoodPreferences = MockUpdateFoodPreferences();

    bloc = FoodPreferencesBloc(
        getFoodPreferences: getFoodPreferences,
        updateFoodPreferences: updateFoodPreferences);
  });

  test('initial State should be initial', () async {
    //assert
    expect(bloc.state, equals(FoodPreferencesInitial()));
  });

  group('getFoodPreferences', () {
    const testFoodPreferences = FoodPreferencesEntity(
        sugarFree: true,
        lactoseFree: false,
        glutenFree: false,
        withoutSoybeans: false,
        withoutNuts: false,
        withoutPeanuts: false,
        version: 1);
    blocTest(
      'should get data from the get use case',
      build: () {
        when(getFoodPreferences(any))
            .thenAnswer((_) async => const Right(testFoodPreferences));
        return bloc..on<FoodPreferencesLoad>((event, emit) {});
      },
      act: (bloc) => bloc.add(FoodPreferencesLoad(completer: Completer())),
      wait: const Duration(milliseconds: 500),
      verify: (_) => verify(getFoodPreferences(NoParams())).called(1),
    );

    blocTest(
      'should emit [FoodPreferencesLoaded] when data is gotten successfully',
      build: () {
        when(getFoodPreferences(any))
            .thenAnswer((_) async => const Right(testFoodPreferences));
        return bloc..on<FoodPreferencesLoad>((event, emit) {});
      },
      act: (bloc) => bloc.add(FoodPreferencesLoad(completer: Completer())),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [const FoodPreferencesLoaded(foodPreferences: testFoodPreferences)],
    );

    blocTest(
      'should emit [FoodPreferencesFailure] when data is get unsuccessfull',
      build: () {
        when(getFoodPreferences(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return bloc..on<FoodPreferencesLoad>((event, emit) {});
      },
      act: (bloc) => bloc.add(const FoodPreferencesLoad()),
      wait: const Duration(milliseconds: 500),
      expect: () => [isA<FoodPreferencesFailure>()],
    );
  });

  group('updateFoodPreferences', () {
    final testFoodPreferencesModel = FoodPreferencesModel.fromJson(
        const JsonDecoder().convert(fixture('food_preferences.json')));
    blocTest(
      'should update food preferences to the update use case',
      build: () {
        when(updateFoodPreferences(any))
            .thenAnswer((_) async => const Right(unit));
        return bloc..on<ChangeFoodPreferences>((event, emit) {});
      },
      act: (bloc) => bloc.add(ChangeFoodPreferences(testFoodPreferencesModel)),
      wait: const Duration(milliseconds: 500),
      verify: (_) => verify(updateFoodPreferences(FoodPreferencesParams(
              foodPreferencesModel: testFoodPreferencesModel)))
          .called(1),
    );

    blocTest(
      'should emit [FoodPreferencesLoading, FoodPreferencesLoaded] when ChangeFoodPreferences event is added',
      build: () {
        when(updateFoodPreferences(any))
            .thenAnswer((_) async => const Right(unit));
        when(getFoodPreferences(any))
            .thenAnswer((_) async => Right(testFoodPreferencesModel));
        return bloc..on<ChangeFoodPreferences>((event, emit) {});
      },
      act: (bloc) => bloc.add(ChangeFoodPreferences(testFoodPreferencesModel)),
      expect: () =>
          [isA<FoodPreferencesLoading>(), isA<FoodPreferencesLoaded>()],
    );

    blocTest<FoodPreferencesBloc, FoodPreferencesState>(
      'should emit [FoodPreferencesFailure] when update food preferences error occurs',
      build: () {
        when(updateFoodPreferences(any))
            .thenAnswer((_) async => Left(DatabaseFailure()));
        return bloc..on<ChangeFoodPreferences>((event, emit) {});
      },
      act: (bloc) => bloc.add(ChangeFoodPreferences(testFoodPreferencesModel)),
      wait: const Duration(milliseconds: 500),
      expect: () => [isA<FoodPreferencesFailure>()],
    );
  });
}
