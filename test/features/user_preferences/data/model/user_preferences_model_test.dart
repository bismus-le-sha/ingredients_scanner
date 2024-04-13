import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/strings/user_preferences_list.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences preferences;
  const testUserPreferencesModel =
      UserPreferencesModel(cameraFlash: true, useBiometrics: false);

  setUp(() {
    preferences = MockSharedPreferences();
  });

  test('should be a subclass of user preference entity', () async {
    expect(testUserPreferencesModel, isA<UserPreferencesEntity>());
  });

  group('from/toSharedPreferences', () {
    test('should return a valid model from SharedPreferences', () async {
      //arrange
      when(preferences.getBool(CAMERA_FLASH)).thenReturn(true);
      when(preferences.getBool(USE_BIOMETRICS)).thenReturn(false);
      //act
      final result = UserPreferencesModel.fromSharedPreferences(preferences);
      //assert
      expect(result, testUserPreferencesModel);
    });

    test('should set SharedPreferences correctly', () async {
      //arrange
      when(preferences.setBool(CAMERA_FLASH, true))
          .thenAnswer(((_) => Future.value(true)));
      when(preferences.setBool(USE_BIOMETRICS, false))
          .thenAnswer(((_) => Future.value(false)));
      //act
      testUserPreferencesModel.toSharedPreferences(preferences);
      //assert
      verify(preferences.setBool(CAMERA_FLASH, true));
      verify(preferences.setBool(USE_BIOMETRICS, false));
    });
  });
}
