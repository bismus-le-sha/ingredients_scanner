import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testUserPreferencesModel =
      UserPreferencesModel(cameraFlash: true, useBiometrics: false);

  test('should be a subclass of weather entity', () async {
    expect(testUserPreferencesModel, isA<UserPreferencesEntity>());
  });

  group('from/toJson', () {
    test('should return a valid modele from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('user_preferences.json'));
      //act
      final result = UserPreferencesModel.fromJson(jsonMap);
      //assert
      expect(result, testUserPreferencesModel);
    });

    test('should return JSON map containing the proper data', () async {
      //act
      final result = testUserPreferencesModel.toJson();
      //assert
      final expectedMap = {"cameraFlash": true, "useBiometrics": false};
      expect(result, expectedMap);
    });
  });
}
