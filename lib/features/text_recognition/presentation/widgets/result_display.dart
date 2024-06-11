import 'package:flutter/material.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import '../../../../core/util/recognized_text_processor/text_processor.dart';

class ResultDisplay extends StatelessWidget {
  final String resultText;
  final FoodPreferencesEntity foodPreferences;

  const ResultDisplay({
    super.key,
    required this.resultText,
    required this.foodPreferences,
  });

  @override
  Widget build(BuildContext context) {
    final textProcessor =
        TextProcessor(foodPreferences: foodPreferences, onlyComposition: true);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        child: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children:
                textProcessor.processComposition(resultText.toLowerCase()),
          ),
        ),
      ),
    );
  }
}
