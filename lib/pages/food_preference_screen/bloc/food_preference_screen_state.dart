part of 'food_preference_screen_bloc.dart';

sealed class FoodPreferenceScreenState extends Equatable {}

final class FoodPreferenceScreenInitial extends FoodPreferenceScreenState {
  @override
  List<Object> get props => [];
}

final class FoodPreferenceScreenLoaded extends FoodPreferenceScreenState {
  @override
  List<Object> get props => [];
}

final class FoodPreferenceScreenLoadingFailure
    extends FoodPreferenceScreenState {
  FoodPreferenceScreenLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
