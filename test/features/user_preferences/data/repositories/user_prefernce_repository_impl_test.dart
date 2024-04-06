import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/data/repositories/user_preferences_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late UserPreferencesRepositoryImpl repositoryImpl;
  late MockUserPreferencesDataSource dataSource;

  setUp(() {
    dataSource = MockUserPreferencesDataSource();
    repositoryImpl = UserPreferencesRepositoryImpl(
      dataSource: dataSource,
    );
  });

  group('get userPreferences', () {
    const testUserPreferencesModel =
        UserPreferencesModel(cameraFlash: true, useBiometrics: false);
    const UserPreferencesEntity testUserPreferences = testUserPreferencesModel;

    test('should return data from data source', () async {
      //arrange
      when(dataSource.getUserPreferences())
          .thenAnswer((_) async => testUserPreferencesModel);
      //act
      final result = await repositoryImpl.getUserPreferences();
      //assert
      verify(dataSource.getUserPreferences());
      expect(result, equals(const Right(testUserPreferences)));
    });

    test('should return DatabaseFailure if cath DatabaseException', () async {
      //arrange
      when(dataSource.getUserPreferences()).thenThrow(DatabaseException());
      //act
      final result = await repositoryImpl.getUserPreferences();
      //assert
      verify(dataSource.getUserPreferences());
      expect(result, Left(DatabaseFailure()));
    });
  });

  group('update userPreferences', () {
    const bool cameraFlash = true;
    const bool useBiometrics = false;

    test('should update cameraFlash value in data source', () async {
      //arrange
      when(dataSource.updateCameraFlash(cameraFlash))
          .thenAnswer((_) async => unit);
      //act
      final result = await repositoryImpl.updateCameraFlash(cameraFlash);
      //assert
      verify(dataSource.updateCameraFlash(cameraFlash));
      expect(result, equals(const Right(unit)));
    });

    test('should update useBiometrics value in data source', () async {
      //arrange
      when(dataSource.updateUseBiometrics(useBiometrics))
          .thenAnswer((_) async => unit);
      //act
      final result = await repositoryImpl.updateUseBiometrics(useBiometrics);
      //assert
      verify(dataSource.updateUseBiometrics(useBiometrics));
      expect(result, equals(const Right(unit)));
    });

    test(
        'should return DatabaseFailure if update cameraFlash cath DatabaseException',
        () async {
      //arrange
      when(dataSource.updateCameraFlash(any)).thenThrow(DatabaseException());
      //act
      final result = await repositoryImpl.updateCameraFlash(cameraFlash);
      //assert
      verify(dataSource.updateCameraFlash(any));
      expect(result, Left(DatabaseFailure()));
    });

    test(
        'should return DatabaseFailure if update useBiometrics cath DatabaseException',
        () async {
      //arrange
      when(dataSource.updateUseBiometrics(any)).thenThrow(DatabaseException());
      //act
      final result = await repositoryImpl.updateUseBiometrics(cameraFlash);
      //assert
      verify(dataSource.updateUseBiometrics(any));
      expect(result, Left(DatabaseFailure()));
    });
  });
}
