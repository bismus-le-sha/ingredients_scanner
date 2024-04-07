import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_data_source.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences preferences;
  late UserPreferencesDataSourceImpl dataSource;

  setUp(() {
    preferences = MockSharedPreferences();
    dataSource = UserPreferencesDataSourceImpl(sharedPreferences: preferences);
  });

  group('get UserPreferences', () {
    const testUserPreferencesModel =
        UserPreferencesModel(cameraFlash: true, useBiometrics: false);
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
    const bool cameraFlash = true;
    const bool useBiometrics = false;

    test('should set cameraFlash to SharedPreferences', () async {
      //arrenge
      when(preferences.setBool(any, any)).thenAnswer((_) async => true);
      //act
      dataSource.updateCameraFlash(cameraFlash);
      //assert
      verify(preferences.setBool(CAMERA_FLASH, cameraFlash)).called(1);
    });

    test('should set useBiometrics to SharedPreferences', () async {
      //arrenge
      when(preferences.setBool(any, any)).thenAnswer((_) async => true);
      //act
      dataSource.updateUseBiometrics(useBiometrics);
      //assert
      verify(preferences.setBool(USE_BIOMETRICS, useBiometrics));
    });
  });
}
