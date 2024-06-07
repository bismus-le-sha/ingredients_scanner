import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';
import 'params/sign_up_params.dart';

class SignUpUseCase implements UseCase<UserCredential, SignUpParams> {
  final AuthenticationRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await repository.signUp(params.signUpEntity);
  }
}
