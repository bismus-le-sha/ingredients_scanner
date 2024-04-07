import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/exceptions.dart';

import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/network/network_info.dart';

import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';

import 'package:ingredients_scanner/features/food_preferences/domain/entities/food_preferences_entity.dart';

import '../../domain/repositories/food_preferences_repository.dart';
import '../datasources/remote/remote_food_preference_data_source.dart';

class FoodPreferencesRepositoryImpl implements FoodPreferencesRepository {
  final RemoteFoodPreferencesDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FoodPreferencesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

//TODO:develop the logic of data recording and synchronization

  @override
  Future<Either<Failure, FoodPreferencesEntity>> getFoodPreference() async {
    networkInfo.isConnected;
    return Right(await remoteDataSource.getFoodPreferences());
  }

  @override
  Future<Either<Failure, Unit>> updateFoodPreference(
      FoodPreferencesModel foodPreferencesModel) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(
            await remoteDataSource.updateFoodPreferences(foodPreferencesModel));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return const Right(unit);
  }
}
