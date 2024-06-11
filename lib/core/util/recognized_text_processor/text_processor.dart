import 'package:flutter/material.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import '../../../../core/util/diet_controller/diet_dictionary.dart';

class TextProcessor {
  final FoodPreferencesEntity foodPreferences;
  final bool onlyComposition;

  TextProcessor({required this.foodPreferences, this.onlyComposition = false});

  Set<String> _getTriggersSet() {
    return DietDictionary().getDietDictionary(
        DietDictionary().fromFoodModelToDiets(foodPreferences));
  }

  String extractCompositionText(String text) {
    RegExp exp = RegExp(r'(состав|ingredients):', caseSensitive: false);
    Match? match = exp.firstMatch(text);
    if (match != null) {
      int startIndex = match.start;
      int endIndex = text.indexOf('.', startIndex);
      if (endIndex != -1) {
        return text.substring(startIndex, endIndex + 1).trim();
      }
    }
    return text;
  }

  List<TextSpan> processComposition(String text) {
    if (onlyComposition) {
      text = extractCompositionText(text);
    }

    List<String> ingredients = splitIngredients(text);
    List<TextSpan> processedIngredients = [];

    for (String ingredient in ingredients) {
      processedIngredients
          .addAll(extractComplexIngredients(ingredient, _getTriggersSet()));
      processedIngredients.add(const TextSpan(text: ', '));
    }
    if (processedIngredients.isNotEmpty) {
      processedIngredients.removeLast();
    }

    return processedIngredients;
  }

  List<String> splitIngredients(String text) {
    List<String> ingredients = [];
    int start = 0;
    int depth = 0;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '(') {
        depth++;
      } else if (text[i] == ')') {
        depth--;
      } else if ((text[i] == ',' || text[i] == ';') && depth == 0) {
        ingredients.add(text.substring(start, i).trim());
        start = i + 1;
      }
    }

    ingredients.add(text.substring(start).trim());
    return ingredients;
  }

  List<TextSpan> extractComplexIngredients(
      String ingredient, Set<String> triggers) {
    List<TextSpan> result = [];
    int depth = 0;
    StringBuffer currentIngredient = StringBuffer();

    for (int i = 0; i < ingredient.length; i++) {
      if (ingredient[i] == '(') {
        depth++;
        currentIngredient.write(ingredient[i]);
      } else if (ingredient[i] == ')') {
        depth--;
        currentIngredient.write(ingredient[i]);
        if (depth == 0) {
          result.add(
              createTextSpan(currentIngredient.toString().trim(), triggers));
          currentIngredient.clear();
        }
      } else {
        currentIngredient.write(ingredient[i]);
      }
    }

    if (currentIngredient.isNotEmpty) {
      result.add(createTextSpan(currentIngredient.toString().trim(), triggers));
    }

    return result;
  }

  List<TextSpan> highlightAllergens(String ingredient, Set<String> triggers) {
    List<TextSpan> spans = [];
    int start = 0;
    String lowerIngredient = ingredient.toLowerCase();

    while (start < lowerIngredient.length) {
      int index = -1;
      String foundAllergen = '';
      RegExpMatch? match;

      for (String trigger in triggers) {
        RegExp regex = RegExp(r'\b' + RegExp.escape(trigger) + r'\b',
            caseSensitive: false);
        match = regex.firstMatch(lowerIngredient.substring(start));
        if (match != null && (index == -1 || match.start < index)) {
          index = match.start + start;
          foundAllergen =
              lowerIngredient.substring(match.start + start, match.end + start);
        }
      }

      if (index != -1) {
        if (index > start) {
          spans.add(TextSpan(text: ingredient.substring(start, index)));
        }
        spans.add(TextSpan(
          text: ingredient.substring(index, index + foundAllergen.length),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ));
        start = index + foundAllergen.length;
      } else {
        spans.add(TextSpan(text: ingredient.substring(start)));
        break;
      }
    }

    return spans;
  }

  TextSpan createTextSpan(String text, Set<String> triggers) {
    return TextSpan(
      children: highlightAllergens(text, triggers),
    );
  }
}
