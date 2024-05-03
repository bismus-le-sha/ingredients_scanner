import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/text_recognition_entity.dart';

import '../repositories/text_recognition_repository.dart';
import 'params/text_recognition_params.dart';

class GetRecognizedText
    implements UseCase<TextRecognitionEntity, TextRecognitionParams> {
  final TextRecognitionRepository repository;

  GetRecognizedText(this.repository);

  @override
  Future<Either<Failure, TextRecognitionEntity>> call(
      TextRecognitionParams params) async {
    return await repository.getRecognizedText(params.path);
  }
}
