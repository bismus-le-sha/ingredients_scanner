import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:ingredients_scanner/features/food_preferences/data/repositories/food_preferences_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late FoodPreferencesRepositoryImpl repository;
  late MockRemoteFoodPreferencesDataSourceImpl remoteDataSource;
  late MockLocalFoodPreferencesDataSourceImpl localDataSource;
  late MockNetworkInfo networkInfo;
  late FoodPreferencesModel testFoodPreferencesModel;

  setUp(() {
    remoteDataSource = MockRemoteFoodPreferencesDataSourceImpl();
    localDataSource = MockLocalFoodPreferencesDataSourceImpl();
    networkInfo = MockNetworkInfo();
    repository = FoodPreferencesRepositoryImpl(
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo,
        localDataSource: localDataSource);
    testFoodPreferencesModel = FoodPreferencesModel.fromJson(
        const JsonDecoder().convert(fixture('food_preferences.json')));
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() => when(networkInfo.isConnected).thenAnswer((_) async => true));
      body();
    });
  }

  group("getFoodPreferences", () {
    // test('should check if the device connected', () async {
    //   //arrange
    //   when(networkInfo.isConnected).thenAnswer((_) async => true);
    //   when(remoteDataSource.getFoodPreferences())
    //       .thenAnswer((_) async => testFoodPreferencesModel);
    //   //act
    //   repository.getFoodPreference();
    //   //assert
    //   verify(networkInfo.isConnected);
    // });

    // runTestOnline(() {});

    test('should get food preferences from local data source', () async {
      //arrange
      when(localDataSource.getFoodPreferences())
          .thenAnswer((_) async => testFoodPreferencesModel);
      //act
      final result = await repository.getFoodPreference();
      //assert
      expect(result, Right(testFoodPreferencesModel));
      verify(localDataSource.getFoodPreferences());
    });
  });

  //SET

  group("updateFoodPreferences", () {
    // test('should check if the device online', () async {
    //   //arrange
    //   when(networkInfo.isConnected).thenAnswer((_) async => true);
    //   when(remoteDataSource.updateFoodPreferences(testFoodPreferencesModel))
    //       .thenAnswer((_) async => unit);
    //   //act
    //   await repository.updateFoodPreference(testFoodPreferencesModel);
    //   //assert
    //   verify(networkInfo.isConnected);
    // });

    // runTestOnline(() {
    //   test('should set to remote data source when connection true', () async {
    //     //arrange
    //     when(remoteDataSource.updateFoodPreferences(testFoodPreferencesModel))
    //         .thenAnswer((_) async => unit);
    //     //act
    //     final result =
    //         await repository.updateFoodPreference(testFoodPreferencesModel);
    //     //assert
    //     verify(
    //         remoteDataSource.updateFoodPreferences(testFoodPreferencesModel));
    //     expect(result, const Right(unit));
    //   });

    //   test(
    //       'should return Server Failure when the call to remote data source is unsuccessful',
    //       () async {
    //     //arrange

    //     when(remoteDataSource.updateFoodPreferences(testFoodPreferencesModel))
    //         .thenThrow(ServerException());
    //     //act
    //     final result =
    //         await repository.updateFoodPreference(testFoodPreferencesModel);
    //     //assert
    //     verify(
    //         remoteDataSource.updateFoodPreferences(testFoodPreferencesModel));
    //     expect(result, Left(ServerFailure()));
    //   });
    // });

    test('should update user preferences in local data source', () async {
      //arrange
      when(localDataSource.updateFoodPreferences(testFoodPreferencesModel))
          .thenAnswer((_) async => unit);
      //act
      final result =
          await repository.updateFoodPreference(testFoodPreferencesModel);
      //assert
      expect(result, equals(const Right(unit)));
      verify(localDataSource.updateFoodPreferences(testFoodPreferencesModel));
    });
  });
}
