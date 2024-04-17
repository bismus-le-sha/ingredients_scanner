import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/entities/text_recognition_entity.dart';

abstract class TextRecognitionRepository {
  Future<Either<Failure, TextRecognitionEntity>> getRecognizedText(String path);
}
