import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';

import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/network/network_info.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';

import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences.dart';

import '../../domain/repositories/user_preferences_repositiory.dart';
import '../data_sources/user_preferences_local_data_sources.dart';
import '../data_sources/user_preferences_remote_data_source.dart';

class UserPreferencesRepositoryImpl implements UserPreferencesRepository {
  final UserPreferencesRemoteDataSource remoteDataSource;
  final UserPreferencesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserPreferencesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, UserPreferencesEntity>> getUserPreferences() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUserPreferences =
            await remoteDataSource.getUserPreferences();
        localDataSource.setUserPreferences(remoteUserPreferences);
        return Right(remoteUserPreferences);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getUserPreferences());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> setUserPreferences(
      UserPreferencesModel userPreferencesModel) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.setUserPreferences(userPreferencesModel);
        localDataSource.setUserPreferences(userPreferencesModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(
            await localDataSource.setUserPreferences(userPreferencesModel));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, Unit>> syncDataWithRemote() async {
    try {
      final localUserPreferences = await localDataSource.getUserPreferences();
      await remoteDataSource.setUserPreferences(localUserPreferences);
      return const Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
