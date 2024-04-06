import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/data/repositories/food_preferences_repository_impl.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late FoodPreferencesRepositoryImpl repository;
  late MockRemoteFoodPreferencesDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    remoteDataSource = MockRemoteFoodPreferencesDataSource();
    networkInfo = MockNetworkInfo();
    repository = FoodPreferencesRepositoryImpl(
        remoteDataSource: remoteDataSource, networkInfo: networkInfo);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() => when(networkInfo.isConnected).thenAnswer((_) async => true));
      body();
    });
  }

  group("getFoodPreferences", () {
    const testFoodPreferencesModel = FoodPreferencesModel(
        shugarFree: true,
        lactoseFree: false,
        glutenFree: false,
        withoutSoybeans: false,
        withoutNuts: false,
        withoutPeanuts: false,
        version: 1);

    const FoodPreferencesEntity testFoodPreferenceEntity =
        testFoodPreferencesModel;

    test('should check if the device connected', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getFoodPreference())
          .thenAnswer((_) async => testFoodPreferencesModel);
      //act
      repository.getFoodPreference();
      //assert
      verify(networkInfo.isConnected);
    });

    runTestOnline(() {});
  });

  //SET

  group("setFoodPreferences", () {
    const testFoodPreferencesModel = FoodPreferencesModel(
        shugarFree: true,
        lactoseFree: false,
        glutenFree: false,
        withoutSoybeans: false,
        withoutNuts: false,
        withoutPeanuts: false,
        version: 1);

    test('should check if the device online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.setFoodPreference(testFoodPreferencesModel))
          .thenAnswer((_) async => unit);
      //act
      await repository.setFoodPreference(testFoodPreferencesModel);
      //assert
      verify(networkInfo.isConnected);
    });

    runTestOnline(() {
      test('should set to remote data source when connection true', () async {
        //arrange
        when(remoteDataSource.setFoodPreference(testFoodPreferencesModel))
            .thenAnswer((_) async => unit);
        //act
        final result =
            await repository.setFoodPreference(testFoodPreferencesModel);
        //assert
        verify(remoteDataSource.setFoodPreference(testFoodPreferencesModel));
        expect(result, const Right(unit));
      });

      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        //arrange

        when(remoteDataSource.setFoodPreference(testFoodPreferencesModel))
            .thenThrow(ServerException());
        //act
        final result =
            await repository.setFoodPreference(testFoodPreferencesModel);
        //assert
        verify(remoteDataSource.setFoodPreference(testFoodPreferencesModel));
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
