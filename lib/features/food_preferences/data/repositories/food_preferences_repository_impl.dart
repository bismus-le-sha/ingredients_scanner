import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/util/network/network_info.dart';

import '../models/food_preferences_model.dart';

import '../../domain/entities/food_preferences_entity.dart';

import '../../domain/repositories/food_preferences_repository.dart';
import '../datasources/local/local_food_preferences_data_source.dart';
import '../datasources/remote/remote_food_preference_data_source.dart';

class FoodPreferencesRepositoryImpl implements FoodPreferencesRepository {
  final RemoteFoodPreferencesDataSource remoteDataSource;
  final LocalFoodPreferencesDataSource localDataSource;
  final NetworkInfo networkInfo;

  FoodPreferencesRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, FoodPreferencesEntity>> getFoodPreference() async {
    return Right(await localDataSource.getFoodPreferences());
  }

  @override
  Future<Either<Failure, Unit>> updateFoodPreference(
      FoodPreferencesModel foodPreferencesModel) async {
    await localDataSource.updateFoodPreferences(foodPreferencesModel);
    return const Right(unit);
  }
}
