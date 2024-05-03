import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../datasources/text_recognition_data_source.dart';
import '../../domain/entities/text_recognition_entity.dart';

import '../../domain/repositories/text_recognition_repository.dart';

class TextRecognitionRepositoryImpl implements TextRecognitionRepository {
  final TextRecognitionDataSource textRecognizer;

  TextRecognitionRepositoryImpl({required this.textRecognizer});

  @override
  Future<Either<Failure, TextRecognitionEntity>> getRecognizedText(
      String path) async {
    return Right(await textRecognizer.getRecognizedText(path));
  }
}
