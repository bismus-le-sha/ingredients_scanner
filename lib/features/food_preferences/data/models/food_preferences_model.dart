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
}
