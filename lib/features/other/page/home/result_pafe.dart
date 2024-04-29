import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_scanner/config/router/router.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/entities/text_recognition_entity.dart';

@RoutePage()
class ResultScreen extends StatelessWidget {
  final TextRecognitionEntity textRecognitionEntity;

  const ResultScreen({super.key, required this.textRecognitionEntity});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.replaceRoute(const TextRecognitionRoute()),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            textRecognitionEntity.text,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
