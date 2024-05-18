import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/text_recognition_entity.dart';
import '../widgets/result_display.dart';

@RoutePage()
class ResultPage extends StatelessWidget {
  final TextRecognitionEntity textRecognitionEntity;

  const ResultPage({super.key, required this.textRecognitionEntity});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ResultDisplay(resultText: textRecognitionEntity.text));
}
