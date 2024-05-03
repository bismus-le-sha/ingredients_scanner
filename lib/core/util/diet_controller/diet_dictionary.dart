import '../../../features/food_preferences/domain/entities/food_preferences_entity.dart';

enum Diets {
  sugarFree,
  lactoseFree,
  glutenFree,
  withoutNuts,
  withoutPeanuts,
  withoutSoybeans
}

class DietDictionary {
  final Set<String> _sugarFree = {'sugar'};
  final Set<String> _lactoseFree = {'milk', 'lactose'};
  final Set<String> _glutenFree = {'gluten', 'wheat'};
  final Set<String> _withoutNuts = {'nuts'};
  final Set<String> _withoutPeanuts = {'peaunuts', 'peaunut'};
  final Set<String> _withoutSoybeans = {'soybeans'};

  Set<String> getDietDictionary(List<Diets> dietsList) {
    Set<String> dietDictionary = {};
    for (var diet in dietsList) {
      switch (diet) {
        case Diets.sugarFree:
          dietDictionary.addAll(_sugarFree);
        case Diets.lactoseFree:
          dietDictionary.addAll(_lactoseFree);
        case Diets.glutenFree:
          dietDictionary.addAll(_glutenFree);
        case Diets.withoutNuts:
          dietDictionary.addAll(_withoutNuts);
        case Diets.withoutPeanuts:
          dietDictionary.addAll(_withoutPeanuts);
        case Diets.withoutSoybeans:
          dietDictionary.addAll(_withoutSoybeans);
      }
    }
    return dietDictionary;
  }

  List<Diets> fromFoodModelToDiets(FoodPreferencesEntity foodModel) {
    List<Diets> diets = [];

    if (foodModel.sugarFree) {
      diets.add(Diets.sugarFree);
    }
    if (foodModel.lactoseFree) {
      diets.add(Diets.lactoseFree);
    }
    if (foodModel.glutenFree) {
      diets.add(Diets.glutenFree);
    }
    if (foodModel.withoutNuts) {
      diets.add(Diets.withoutNuts);
    }
    if (foodModel.withoutPeanuts) {
      diets.add(Diets.withoutPeanuts);
    }
    if (foodModel.withoutSoybeans) {
      diets.add(Diets.withoutSoybeans);
    }

    return diets;
  }
  // List<Diets> fromJsonToDiets(Map<String, bool> json) {
  //   List<Diets> diets = [];

  //   json.forEach((key, value) {
  //     if (value) {
  //       Diets diet =
  //           Diets.values.firstWhere((e) => e.toString() == 'Diets.$key');
  //       diets.add(diet);
  //     }
  //   });

  //   return diets;
  // }
}
