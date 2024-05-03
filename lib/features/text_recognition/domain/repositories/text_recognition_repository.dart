import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/text_recognition_entity.dart';

abstract class TextRecognitionRepository {
  Future<Either<Failure, TextRecognitionEntity>> getRecognizedText(String path);
}
