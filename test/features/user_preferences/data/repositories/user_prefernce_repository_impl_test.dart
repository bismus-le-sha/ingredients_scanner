import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/data/repositories/user_preferences_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UserPreferencesRepositoryImpl repositoryImpl;
  late MockUserPreferencesLocalDataSource localDataSource;
  late MockUserPreferencesRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    localDataSource = MockUserPreferencesLocalDataSource();
    remoteDataSource = MockUserPreferencesRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repositoryImpl = UserPreferencesRepositoryImpl(
        localDataSource: localDataSource,
        remoteDataSource: remoteDataSource,
        networkInfo: networkInfo);
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() => when(networkInfo.isConnected).thenAnswer((_) async => true));
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() => when(networkInfo.isConnected).thenAnswer((_) async => false));
      body();
    });
  }

  group('getUserPreferences', () {
    const testUserPreferencesModel =
        UserPreferencesModel(cameraFlash: true, useBiometrics: false);
    const UserPreferencesEntity testUserPreferences = testUserPreferencesModel;

    test('should check if the device online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.getUserPreferences())
          .thenAnswer((_) async => testUserPreferencesModel);
      when(localDataSource.setUserPreferences(testUserPreferencesModel))
          .thenAnswer((_) async => unit);
      //act
      final result = await repositoryImpl.getUserPreferences();
      //assert
      verify(networkInfo.isConnected);
      verify(remoteDataSource.getUserPreferences());
      expect(result, equals(const Right(testUserPreferences)));
    });

    runTestOnline(() {
      setUp(() {
        when(remoteDataSource.getUserPreferences())
            .thenAnswer((_) async => testUserPreferencesModel);
        when(localDataSource.setUserPreferences(testUserPreferencesModel))
            .thenAnswer((_) async => unit);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(remoteDataSource.getUserPreferences())
            .thenAnswer((_) async => testUserPreferencesModel);
        //act
        final result = await repositoryImpl.getUserPreferences();
        //assert
        verify(remoteDataSource.getUserPreferences());
        expect(result, equals(const Right(testUserPreferences)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        //act
        await repositoryImpl.getUserPreferences();
        //assert
        verify(remoteDataSource.getUserPreferences());
        verify(localDataSource.setUserPreferences(testUserPreferencesModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(remoteDataSource.getUserPreferences())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getUserPreferences();
        //assert
        verify(remoteDataSource.getUserPreferences());
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(localDataSource.getUserPreferences())
            .thenAnswer((_) async => testUserPreferencesModel);
        //act
        final result = await repositoryImpl.getUserPreferences();
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getUserPreferences());
        expect(result, equals(const Right(testUserPreferences)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        //arrange
        when(localDataSource.getUserPreferences()).thenThrow(CacheException());
        //act
        final result = await repositoryImpl.getUserPreferences();
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getUserPreferences());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

//SetUserPreferences

  group('setUserPreference', () {
    const testUserPreferencesModel =
        UserPreferencesModel(cameraFlash: true, useBiometrics: false);

    test('should check if the device online', () async {
      //arrange
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(remoteDataSource.setUserPreferences(testUserPreferencesModel))
          .thenAnswer((_) async => unit);
      when(localDataSource.setUserPreferences(testUserPreferencesModel))
          .thenAnswer((_) async => unit);
      //act
      final result =
          await repositoryImpl.setUserPreferences(testUserPreferencesModel);
      //assert
      verify(networkInfo.isConnected);
      verify(remoteDataSource.setUserPreferences(testUserPreferencesModel));
      expect(result, equals(const Right(unit)));
    });

    runTestOnline(() {
      setUp(() {
        when(remoteDataSource.setUserPreferences(testUserPreferencesModel))
            .thenAnswer((_) async => unit);
        when(localDataSource.setUserPreferences(testUserPreferencesModel))
            .thenAnswer((_) async => unit);
      });

      test(
          'should set data to remote when the call to remote data source is successful',
          () async {
        //arrange
        when(remoteDataSource.setUserPreferences(testUserPreferencesModel))
            .thenAnswer((_) async => unit);
        //act
        final result =
            await repositoryImpl.setUserPreferences(testUserPreferencesModel);
        //assert
        verify(remoteDataSource.setUserPreferences(testUserPreferencesModel));
        verify(localDataSource.setUserPreferences(testUserPreferencesModel));
        expect(result, equals(const Right(unit)));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(remoteDataSource.setUserPreferences(testUserPreferencesModel))
            .thenThrow(ServerException());
        //act
        final result =
            await repositoryImpl.setUserPreferences(testUserPreferencesModel);
        //assert
        verify(remoteDataSource.setUserPreferences(testUserPreferencesModel));
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should get locally data when the call to remote data source is unsuccessful',
          () async {
        //arrange
        when(localDataSource.setUserPreferences(testUserPreferencesModel))
            .thenAnswer((_) async => unit);
        //act
        final result =
            await repositoryImpl.setUserPreferences(testUserPreferencesModel);
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.setUserPreferences(testUserPreferencesModel));
        expect(result, equals(const Right(unit)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        //arrange
        when(localDataSource.setUserPreferences(testUserPreferencesModel))
            .thenThrow(CacheException());
        //act
        final result =
            await repositoryImpl.setUserPreferences(testUserPreferencesModel);
        //assert
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.setUserPreferences(testUserPreferencesModel));
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
