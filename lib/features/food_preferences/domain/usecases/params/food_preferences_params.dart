import 'package:equatable/equatable.dart';
import '../../../data/models/food_preferences_model.dart';

class FoodPreferencesParams extends Equatable {
  final FoodPreferencesModel foodPreferencesModel;

  const FoodPreferencesParams({required this.foodPreferencesModel});

  @override
  List<Object?> get props => [foodPreferencesModel];
}
