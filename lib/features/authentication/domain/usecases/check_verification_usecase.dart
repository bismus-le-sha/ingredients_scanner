import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/check_verification_params.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class CheckVerificationUseCase
    implements UseCase<Unit, CheckVerificationParams> {
  final AuthenticationRepository repository;
  CheckVerificationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CheckVerificationParams params) async {
    return await repository.checkEmailVerification(params.completer);
  }
}
