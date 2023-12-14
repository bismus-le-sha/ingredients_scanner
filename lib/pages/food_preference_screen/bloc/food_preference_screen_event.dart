part of 'food_preference_screen_bloc.dart';

sealed class FoodPreferenceScreenEvent extends Equatable {
  const FoodPreferenceScreenEvent();

  @override
  List<Object> get props => [];
}

// final class LoadFoodPreferenceScreen extends FoodPreferenceScreenEvent {
//   const LoadFoodPreferenceScreen({this.completer});

//   final Completer? completer;

//   @override
//   List<Object> get props => [completer];
// }
