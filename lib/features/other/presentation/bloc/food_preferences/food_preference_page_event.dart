part of 'food_preference_page_bloc.dart';

sealed class FoodPreferencePageEvent extends Equatable {}

final class LoadFoodPreferencePage extends FoodPreferencePageEvent {
  LoadFoodPreferencePage({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
