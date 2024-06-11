import 'package:flutter/material.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';
import 'package:ingredients_scanner/features/text_recognition/presentation/widgets/result_display.dart';

class ResultPageController extends StatefulWidget {
  final String resultText;
  final FoodPreferencesEntity foodPreferences;

  const ResultPageController({
    super.key,
    required this.resultText,
    required this.foodPreferences,
  });

  @override
  State<ResultPageController> createState() => _ResultPageControllerState();
}

class _ResultPageControllerState extends State<ResultPageController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //   bottom: 16.0,
        //   right: 16.0,
        //   child: FloatingActionButton(
        //     onPressed: () => (),
        //     child: const Icon(Icons.toggle_on),
        //   ),
        // ),
        ResultDisplay(
          resultText: widget.resultText,
          foodPreferences: widget.foodPreferences,
        )
      ],
    );
  }
}
