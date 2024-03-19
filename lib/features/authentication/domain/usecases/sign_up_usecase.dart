import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/sign_up_entity.dart';
import '../repositories/authentication_repository.dart';

class SignUpUseCase implements UseCase<UserCredential, SignUpEntity> {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpEntity signup) async {
    return await repository.signUp(signup);
  }
}
