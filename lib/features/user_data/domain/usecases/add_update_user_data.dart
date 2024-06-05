import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_data_repository.dart';
import 'params/user_data_params.dart';

class AddUpdateUserData implements UseCase<Unit, UserDataParams> {
  final UserDataRepository repository;

  AddUpdateUserData(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UserDataParams params) async {
    return await repository.addUpdateUserData(params.userData);
  }
}
