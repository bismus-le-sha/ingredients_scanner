import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';

import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/network/network_info.dart';

import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';

import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';

import '../../domain/repositories/food_preferences_repository.dart';
import '../datasources/food_preference_data_source.dart';

class FoodPreferencesRepositoryImpl implements FoodPreferencesRepository {
  final RemoteFoodPreferencesDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FoodPreferencesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, FoodPreferencesEntity>> getFoodPreference() async {
    networkInfo.isConnected;
    return Right(await remoteDataSource.getFoodPreference());
  }

  @override
  Future<Either<Failure, Unit>> setFoodPreference(
      FoodPreferencesModel foodPreferencesModel) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
            await remoteDataSource.setFoodPreference(foodPreferencesModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return const Right(unit);
  }
}
