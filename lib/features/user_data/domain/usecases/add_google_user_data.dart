import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_data_repository.dart';

class AddGoogleUserData implements UseCase<Unit, NoParams> {
  final UserDataRepository repository;

  AddGoogleUserData(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.addGoogleUserData();
  }
}
