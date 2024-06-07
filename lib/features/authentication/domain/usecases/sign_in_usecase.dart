import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/params/sign_in_params.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class SignInUseCase implements UseCase<UserCredential, SignInParams> {
  final AuthenticationRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignInParams params) async {
    return await repository.signIn(params.signInEntity);
  }
}
