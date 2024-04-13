import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/strings/food_preferences_list.dart';
import '../../domain/entities/food_preferences_entity.dart';

class FoodPreferencesModel extends FoodPreferencesEntity {
  const FoodPreferencesModel({
    required super.sugarFree,
    required super.lactoseFree,
    required super.glutenFree,
    required super.withoutNuts,
    required super.withoutPeanuts,
    required super.withoutSoybeans,
    required super.version,
  });

  factory FoodPreferencesModel.fromJson(Map<String, dynamic> json) {
    return FoodPreferencesModel(
        sugarFree: json['sugarFree'],
        lactoseFree: json['lactoseFree'],
        glutenFree: json['glutenFree'],
        withoutNuts: json['withoutNuts'],
        withoutPeanuts: json['withoutPeanuts'],
        withoutSoybeans: json['withoutSoybeans'],
        version: json['version']);
  }

  Map<String, dynamic> toJson() {
    return {
      "sugarFree": sugarFree,
      "lactoseFree": lactoseFree,
      "glutenFree": glutenFree,
      "withoutNuts": withoutNuts,
      "withoutPeanuts": withoutPeanuts,
      "withoutSoybeans": withoutSoybeans,
      "version": version
    };
  }

  FoodPreferencesModel copyWith({
    bool? sugarFree,
    bool? lactoseFree,
    bool? glutenFree,
    bool? withoutNuts,
    bool? withoutPeanuts,
    bool? withoutSoybeans,
    int? version,
  }) {
    return FoodPreferencesModel(
        sugarFree: sugarFree ?? this.sugarFree,
        lactoseFree: lactoseFree ?? this.lactoseFree,
        glutenFree: glutenFree ?? this.glutenFree,
        withoutNuts: withoutNuts ?? this.withoutNuts,
        withoutPeanuts: withoutPeanuts ?? this.withoutPeanuts,
        withoutSoybeans: withoutSoybeans ?? this.withoutSoybeans,
        version: version ?? this.version);
  }

  factory FoodPreferencesModel.fromSharedPreferences(
      SharedPreferences preferences) {
    return FoodPreferencesModel(
      sugarFree: preferences.getBool(SUGAR_FREE) ?? false,
      lactoseFree: preferences.getBool(LACTOSE_FREE) ?? false,
      glutenFree: preferences.getBool(GLUTEN_FREE) ?? false,
      withoutNuts: preferences.getBool(WITHOUT_NUTS) ?? false,
      withoutPeanuts: preferences.getBool(WITHOUT_PEANUTS) ?? false,
      withoutSoybeans: preferences.getBool(WITHOUT_SOYBEANS) ?? false,
      version: preferences.getInt(VERSION) ?? 1,
    );
  }

  void toSharedPreferences(SharedPreferences preferences) {
    preferences.setBool(SUGAR_FREE, sugarFree);
    preferences.setBool(LACTOSE_FREE, lactoseFree);
    preferences.setBool(GLUTEN_FREE, glutenFree);
    preferences.setBool(WITHOUT_NUTS, withoutNuts);
    preferences.setBool(WITHOUT_PEANUTS, withoutPeanuts);
    preferences.setBool(WITHOUT_SOYBEANS, withoutSoybeans);
    preferences.setInt(VERSION, version);
  }
}
