import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class CheckVerificationUseCase implements UseCase<Unit, Completer> {
  final AuthenticationRepository repository;
  CheckVerificationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Completer completer) async {
    return await repository.checkEmailVerification(completer);
  }
}
