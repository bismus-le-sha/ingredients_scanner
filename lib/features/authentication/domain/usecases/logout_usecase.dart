import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/authentication_repository.dart';

class LogOutUseCase implements UseCase<Unit, NoParams> {
  final AuthenticationRepository repository;

  LogOutUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.logOut();
  }
}
