part of 'food_preferences_bloc.dart';

abstract class FoodPreferencesEvent extends Equatable {
  const FoodPreferencesEvent();

  @override
  List<Object?> get props => [];
}

class FoodPreferencesLoad extends FoodPreferencesEvent {
  const FoodPreferencesLoad({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class ChangeFoodPreferences extends FoodPreferencesEvent {
  const ChangeFoodPreferences(this.foodPreferences);

  final FoodPreferencesModel foodPreferences;

  @override
  List<Object?> get props => [foodPreferences];
}
