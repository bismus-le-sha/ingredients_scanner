import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/text_recognition/data/models/text_recognition_model.dart';
import 'package:ingredients_scanner/features/text_recognition/data/repositories/text_recognition_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockTextRecognitionDataSource dataSource;
  late TextRecognitionRepositoryImpl repositoryImpl;

  setUp(() => {
        dataSource = MockTextRecognitionDataSource(),
        repositoryImpl =
            TextRecognitionRepositoryImpl(textRecognizer: dataSource)
      });

  final testTextRecognitionModel = TextRecognitionModel(text: 'text');
  const String path = 'path';

  test('should get text recognition entity from the recognizer', () async {
    //arrange
    when(dataSource.getRecognizedText(any))
        .thenAnswer((_) async => testTextRecognitionModel);
    //act
    final result = await repositoryImpl.getRecognizedText(path);
    //assert
    expect(result, Right(testTextRecognitionModel));
    verify(dataSource.getRecognizedText(path));
  });
}
