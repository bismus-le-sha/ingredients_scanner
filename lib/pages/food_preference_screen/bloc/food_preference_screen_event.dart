part of 'food_preference_screen_bloc.dart';

sealed class FoodPreferenceScreenEvent extends Equatable {}

final class LoadFoodPreferenceScreen extends FoodPreferenceScreenEvent {
  LoadFoodPreferenceScreen({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
