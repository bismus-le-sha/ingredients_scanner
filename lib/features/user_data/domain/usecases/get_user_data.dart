import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_data_entity.dart';

import '../repositories/user_data_repository.dart';

class GetUserData implements UseCase<UserDataEntity, NoParams> {
  final UserDataRepository repository;

  GetUserData(this.repository);

  @override
  Future<Either<Failure, UserDataEntity>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
