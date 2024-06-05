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
    UserPreferencesEntity testUserPreferences = testUserPreferencesModel;

    test('should return data from data source', () async {
      //arrange
      when(dataSource.getUserPreferences())
          .thenAnswer((_) async => testUserPreferencesModel);
      //act
      final result = await repositoryImpl.getUserPreferences();
      //assert
      verify(dataSource.getUserPreferences());
      expect(result, equals(Right(testUserPreferences)));
    });

    test('should return DatabaseFailure if cath DatabaseException', () async {
      //arrange
      when(dataSource.getUserPreferences()).thenThrow(CacheException());
      //act
      final result = await repositoryImpl.getUserPreferences();
      //assert
      verify(dataSource.getUserPreferences());
      expect(result, Left(DatabaseFailure()));
    });
  });

  group('update userPreferences', () {
    const testUserPreferencesModel =
        UserPreferencesModel(cameraFlash: true, useBiometrics: false);
    test('should update user preferences in data source', () async {
      //arrange
      when(dataSource.updateUserPreferences(testUserPreferencesModel))
          .thenAnswer((_) async => unit);
      //act
      final result =
          await repositoryImpl.updateUserPreferences(testUserPreferencesModel);
      //assert
      verify(dataSource.updateUserPreferences(testUserPreferencesModel));
      expect(result, equals(const Right(unit)));
    });

    test(
        'should return DatabaseFailure if update user preferences cath DatabaseException',
        () async {
      //arrange
      when(dataSource.updateUserPreferences(any)).thenThrow(CacheException());
      //act
      final result =
          await repositoryImpl.updateUserPreferences(testUserPreferencesModel);
      //assert
      verify(dataSource.updateUserPreferences(any));
      expect(result, Left(DatabaseFailure()));
    });
  });
}
