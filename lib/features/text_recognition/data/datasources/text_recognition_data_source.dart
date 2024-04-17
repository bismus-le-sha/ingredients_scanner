import 'dart:io';

import 'package:ingredients_scanner/features/text_recognition/data/models/text_recognition_model.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class TextRecognitionDataSource {
  Future<TextRecognitionModel> getRecognizedText(String path);
}

class TextRecognitionDataSourceImpl implements TextRecognitionDataSource {
  final TextRecognizer textRecognizer;

  TextRecognitionDataSourceImpl({
    required this.textRecognizer,
  });

  @override
  Future<TextRecognitionModel> getRecognizedText(String path) async {
    final recognizedText =
        await textRecognizer.processImage(InputImage.fromFile(File(path)));
    return TextRecognitionModel(text: recognizedText.text);
  }

  void dispose() {
    textRecognizer.close();
  }
}
