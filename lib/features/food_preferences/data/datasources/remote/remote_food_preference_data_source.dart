import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../models/food_preferences_model.dart';

import '../../../../../core/constants/core_consts.dart';

abstract class RemoteFoodPreferencesDataSource {
  Future<FoodPreferencesModel> getFoodPreferences();
  Future<Unit> updateFoodPreferences(FoodPreferencesModel foodPreferencesModel);
}

class RemoteFoodPreferencesDataSourceImpl
    implements RemoteFoodPreferencesDataSource {
  final FirebaseFirestore instance;
  late final CollectionReference _foodPreferencesRef;

  RemoteFoodPreferencesDataSourceImpl({required this.instance}) {
    _foodPreferencesRef = instance
        .collection(foodPreferencesDBName)
        .withConverter<FoodPreferencesModel>(
            fromFirestore: (snapshots, _) =>
                FoodPreferencesModel.fromJson(snapshots.data()!),
            toFirestore: (foodPreferences, _) => foodPreferences.toJson());
  }

  @override
  Future<FoodPreferencesModel> getFoodPreferences() {
    return Future.value(_foodPreferencesRef.get() as FoodPreferencesModel);
  }

  @override
  Future<Unit> updateFoodPreferences(
      FoodPreferencesModel foodPreferencesModel) {
    _foodPreferencesRef.doc().set(foodPreferencesModel);
    return Future.value(unit);
  }
}
