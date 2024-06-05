import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/features/user_data/data/models/user_data_model.dart';
import 'package:ingredients_scanner/features/user_data/domain/entities/user_data_entity.dart';

import '../../../../core/error/failures.dart';

abstract class UserDataRepository {
  Future<Either<Failure, UserDataEntity>> getUserData();
  Future<Either<Failure, Unit>> addUpdateUserData(UserDataModel userModel);
  Future<Either<Failure, Unit>> addGoogleUserData();
}
