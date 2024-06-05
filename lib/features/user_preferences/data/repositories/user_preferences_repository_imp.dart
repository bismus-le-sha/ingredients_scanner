import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../models/user_preferences_model.dart';

import '../../domain/entities/user_preferences_entity.dart';

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
    } on CacheException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserPreferences(
      UserPreferencesModel userPreferencesModel) async {
    try {
      await dataSource.updateUserPreferences(userPreferencesModel);
      return const Right(unit);
    } on CacheException {
      return Left(DatabaseFailure());
    }
  }
}
