import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ingredients_scanner/features/text_recognition/data/datasources/text_recognition_data_source.dart';
import 'package:ingredients_scanner/features/text_recognition/data/models/text_recognition_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockTextRecognizer textRecognizer;
  late TextRecognitionDataSourceImpl dataSourceImpl;
  late RecognizedText resultText;

  setUp(() {
    textRecognizer = MockTextRecognizer();

    dataSourceImpl =
        TextRecognitionDataSourceImpl(textRecognizer: textRecognizer);
    resultText = RecognizedText(text: 'text', blocks: []);
  });

  const String path = 'path';

  test('should return TextRecognitionModel from picture file', () async {
    //arrange
    when(textRecognizer.processImage(any))
        .thenAnswer((_) => Future.value(resultText));
    //act
    final result = await dataSourceImpl.getRecognizedText(path);
    //assert
    verify(textRecognizer.processImage(any)).called(1);
    expect(result, isA<TextRecognitionModel>());
    expect(result.text, resultText.text);
  });

  test('should close textRecognizer', () async {
    //act
    dataSourceImpl.dispose();
    //assert
    verify(textRecognizer.close()).called(1);
  });
}
