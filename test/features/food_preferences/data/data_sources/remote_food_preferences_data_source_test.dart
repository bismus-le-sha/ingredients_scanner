import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/core/constants/core_consts.dart';
import 'package:ingredients_scanner/features/food_preferences/data/datasources/remote/remote_food_preference_data_source.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockFirebaseFirestore instance;
  late RemoteFoodPreferencesDataSourceImpl remoteDataSource;
  late FoodPreferencesModel testFoodPreferencesModel;
  late MockCollectionReference<Map<String, dynamic>> collectionReference;

  setUp(() {
    instance = MockFirebaseFirestore();
    collectionReference = MockCollectionReference<Map<String, dynamic>>();
    remoteDataSource = RemoteFoodPreferencesDataSourceImpl(instance: instance);
    testFoodPreferencesModel = FoodPreferencesModel.fromJson(
        const JsonDecoder().convert(fixture('food_preferences.json')));
  });

  void convertor(Function body) {
    group('convertor', () {
      setUp(() => when(instance.collection(any).withConverter(
              fromFirestore: (snapshots, _) =>
                  FoodPreferencesModel.fromJson(snapshots.data()!),
              toFirestore: (foodPreferences, _) => foodPreferences.toJson()))
          .thenReturn(testFoodPreferencesModel
              as CollectionReference<FoodPreferencesModel>));
      body();
    });
  }

  // group('getFoodPreferences', () {
  //   test('should  return FoodPreferences from FirebaseStore', () async {
  //     //arrange
  //     when(instance.collection(FOOD_PREFERENCES_DB_NAME))
  //         .thenReturn(collectionReference);
  //     when(collectionReference.withConverter(
  //             fromFirestore: (snapshots, _) =>
  //                 FoodPreferencesModel.fromJson(snapshots.data()!),
  //             toFirestore: (foodPreferences, _) => foodPreferences.toJson()))
  //         .thenReturn(testFoodPreferencesModel
  //             as CollectionReference<FoodPreferencesModel>);

  //     //act
  //     final result = await remoteDataSource.getFoodPreferences();
  //     //assert
  //     expect(result, isA<FoodPreferencesModel>());
  //   });
  // });
}
