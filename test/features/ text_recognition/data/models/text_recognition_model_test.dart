import 'package:ingredients_scanner/features/text_recognition/data/models/text_recognition_model.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/entities/text_recognition_entity.dart';
import 'package:test/test.dart';

void main() {
  final testTextRecognitionModel = TextRecognitionModel(text: 'text');

  test('should be a subclass of text tecognition entity', () async {
    expect(testTextRecognitionModel, isA<TextRecognitionEntity>());
  });
}
