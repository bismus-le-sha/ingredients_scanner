import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class VerifyEmailUseCase implements UseCase<Unit, NoParams> {
  final AuthenticationRepository repository;

  VerifyEmailUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.verifyEmail();
  }
}
