import 'package:equatable/equatable.dart';
import 'package:ingredients_scanner/features/food_preferences/data/models/food_preferences_model.dart';

class FoodPreferencesParams extends Equatable {
  final FoodPreferencesModel foodPreferencesModel;

  const FoodPreferencesParams({required this.foodPreferencesModel});

  @override
  List<Object?> get props => [foodPreferencesModel];
}
