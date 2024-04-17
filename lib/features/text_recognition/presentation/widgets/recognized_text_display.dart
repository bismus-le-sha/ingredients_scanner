import 'package:flutter/widgets.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/entities/text_recognition_entity.dart';

class RecognizedTextDisplay extends StatelessWidget {
  final TextRecognitionEntity textRecognitionEntity;
  const RecognizedTextDisplay({super.key, required this.textRecognitionEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            textRecognitionEntity.text,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
