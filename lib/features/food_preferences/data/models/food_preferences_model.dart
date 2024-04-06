import '../../domain/entities/food_preferences_entity.dart';

class FoodPreferencesModel extends FoodPreferencesEntity {
  const FoodPreferencesModel({
    required super.shugarFree,
    required super.lactoseFree,
    required super.glutenFree,
    required super.withoutNuts,
    required super.withoutPeanuts,
    required super.withoutSoybeans,
    required super.version,
  });

  factory FoodPreferencesModel.fromJson(Map<String, dynamic> json) {
    return FoodPreferencesModel(
        shugarFree: json['shugarFree'],
        lactoseFree: json['lactoseFree'],
        glutenFree: json['glutenFree'],
        withoutNuts: json['withoutNuts'],
        withoutPeanuts: json['withoutPeanuts'],
        withoutSoybeans: json['withoutSoybeans'],
        version: json['version']);
  }

  Map<String, dynamic> toJson() {
    return {
      "shugarFree": shugarFree,
      "lactoseFree": lactoseFree,
      "glutenFree": glutenFree,
      "withoutNuts": withoutNuts,
      "withoutPeanuts": withoutPeanuts,
      "withoutSoybeans": withoutSoybeans,
      "version": version
    };
  }
}
