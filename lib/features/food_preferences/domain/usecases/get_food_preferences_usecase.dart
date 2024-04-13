import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/food_preferences_entity.dart';
import '../repositories/food_preferences_repository.dart';

class GetFoodPreferences implements UseCase<FoodPreferencesEntity, NoParams> {
  final FoodPreferencesRepository repository;

  GetFoodPreferences(this.repository);

  @override
  Future<Either<Failure, FoodPreferencesEntity>> call(NoParams params) async {
    return await repository.getFoodPreference();
  }
}
