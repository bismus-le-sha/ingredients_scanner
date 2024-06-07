import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/first_page_entity.dart';
import '../repositories/authentication_repository.dart';

class FirstPageUseCase implements UseCase<FirstPageEntity, NoParams> {
  final AuthenticationRepository repository;

  FirstPageUseCase(this.repository);

  @override
  Future<Either<Failure, FirstPageEntity>> call(NoParams params) async {
    return repository.firstPage();
  }
}
