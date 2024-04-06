import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';

import 'package:ingredients_scanner/core/error/failures.dart';

import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';

import '../../domain/repositories/user_preferences_repositiory.dart';
import '../data_sources/user_preferences_data_source.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesDataSource dataSource;

  UserPreferencesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, UserPreferencesEntity>> getUserPreferences() async {
    try {
      final userPreferences = await dataSource.getUserPreferences();
      return Right(userPreferences);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCameraFlash(bool value) async {
    try {
      await dataSource.updateCameraFlash(value);
      return const Right(unit);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUseBiometrics(bool value) async {
    try {
      await dataSource.updateUseBiometrics(value);
      return const Right(unit);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
