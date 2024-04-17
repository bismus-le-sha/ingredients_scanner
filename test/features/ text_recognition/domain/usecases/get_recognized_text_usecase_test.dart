import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/entities/text_recognition_entity.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/usecases/get_recognized_text_usecase.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/usecases/params/text_recognition_params.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GetRecognizedText usecase;
  late MockTextRecognitionRepository repository;

  setUp(() => {
        repository = MockTextRecognitionRepository(),
        usecase = GetRecognizedText(repository)
      });

  final testTextRecognition = TextRecognitionEntity(text: 'text');
  const String path = 'path';

  test('should get text recognition from the repository', () async {
    //arrange
    when(repository.getRecognizedText(path))
        .thenAnswer((_) async => Right(testTextRecognition));
    //act
    final result = await usecase.call(const TextRecognitionParams(path: path));
    //assert
    expect(result, Right(testTextRecognition));
  });
}
