import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/authentication/data/models/sign_up_model.dart';
import 'package:ingredients_scanner/features/authentication/domain/entities/sign_up_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const testSignUpModel = SignUpModel(
      name: 'boby',
      email: 'boby@gmail.com',
      password: 'password',
      repeatedPassword: '');

  test('should be a subclass of weather entity', () async {
    expect(testSignUpModel, isA<SignUpEntity>());
  });

  group('from/toJson', () {
    test('should return a valid modele from JSON', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('sign_up.json'));
      //act
      final result = SignUpModel.fromJson(jsonMap);
      //assert
      expect(result, testSignUpModel);
    });

    test('should return JSON map containing the proper data', () async {
      //act
      final result = testSignUpModel.toJson();
      //assert
      final expectedMap = {
        "name": "boby",
        "email": "boby@gmail.com",
        "password": "password",
      };
      expect(result, expectedMap);
    });
  });
}
