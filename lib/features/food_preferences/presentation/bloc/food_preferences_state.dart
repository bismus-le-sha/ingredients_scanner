part of 'food_preferences_bloc.dart';

abstract class FoodPreferencesState extends Equatable {
  const FoodPreferencesState();

  @override
  List<Object?> get props => [];
}

class FoodPreferencesInitial extends FoodPreferencesState {}

class FoodPreferencesLoading extends FoodPreferencesState {}

class FoodPreferencesLoaded extends FoodPreferencesState {
  final FoodPreferencesEntity foodPreferences;

  const FoodPreferencesLoaded({required this.foodPreferences});

  @override
  List<Object?> get props => [foodPreferences];
}

class FoodPreferencesUpdated extends FoodPreferencesState {}

class FoodPreferencesFailure extends FoodPreferencesState {
  final String message;

  const FoodPreferencesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
