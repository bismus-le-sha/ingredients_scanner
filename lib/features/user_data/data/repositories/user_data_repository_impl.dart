import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';

import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/features/user_data/data/datasources/local/local_user_data_data_source.dart';

import 'package:ingredients_scanner/features/user_data/data/models/user_data_model.dart';

import 'package:ingredients_scanner/features/user_data/domain/entities/user_data_entity.dart';

import '../../../../core/util/network/network_info.dart';
import '../../domain/repositories/user_data_repository.dart';
import '../datasources/remote/remote_user_data_data_source.dart';

class UserDataRepositoryImpl extends UserDataRepository {
  final RemoteUserDataDataSource remoteDataDataSource;
  final LocalUserDataDataSource localDataDataSource;
  final NetworkInfo networkInfo;

  UserDataRepositoryImpl(
      {required this.remoteDataDataSource,
      required this.localDataDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, UserDataEntity>> getUserData() async {
    if (await networkInfo.isConnected) {
      try {
        final userData = await remoteDataDataSource.getUserData();
        localDataDataSource.cacheUserData(userData);
        return Right(userData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataDataSource.getLastUserData());
      } on CacheException {
        return Left(CameraFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addUpdateUserData(
      UserDataModel userModel) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataDataSource.addUpdateUserData(userModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addGoogleUserData() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataDataSource.addGoogleUserData());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
