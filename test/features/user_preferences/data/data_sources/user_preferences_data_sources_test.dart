import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/resources/user_preferences_list.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_data_source.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences preferences;
  late UserPreferencesDataSourceImpl dataSource;
  late UserPreferencesModel testUserPreferencesModel;

  setUp(() {
    preferences = MockSharedPreferences();
    dataSource = UserPreferencesDataSourceImpl(sharedPreferences: preferences);
    testUserPreferencesModel =
        const UserPreferencesModel(cameraFlash: true, useBiometrics: false);
  });

  group('get UserPreferences', () {
    test('should return UserPreferences from SharedPreferences', () async {
      //arrange
      when(preferences.getBool(CAMERA_FLASH)).thenReturn(true);
      when(preferences.getBool(USE_BIOMETRICS)).thenReturn(false);
      //act
      final result = await dataSource.getUserPreferences();
      //assert
      expect(result, equals(testUserPreferencesModel));
    });
  });

  group('update UserPreferences', () {
    test('should update preferences to SharedPreferences', () async {
      //arrenge
      when(preferences.setBool(any, any)).thenAnswer((_) async => true);
      //act
      dataSource.updateUserPreferences(testUserPreferencesModel);
      //assert
      verify(preferences.setBool(
              CAMERA_FLASH, testUserPreferencesModel.cameraFlash))
          .called(1);
      verify(preferences.setBool(
              USE_BIOMETRICS, testUserPreferencesModel.useBiometrics))
          .called(1);
    });
  });
}
