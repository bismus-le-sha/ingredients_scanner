part of 'food_preference_page_bloc.dart';

sealed class FoodPreferencePageState extends Equatable {}

final class FoodPreferencePageInitial extends FoodPreferencePageState {
  @override
  List<Object?> get props => [];
}

class FoodPreferencePageLoading extends FoodPreferencePageState {
  @override
  List<Object?> get props => [];
}

final class FoodPreferencePageLoaded extends FoodPreferencePageState {
  FoodPreferencePageLoaded({required this.productPreferences});
  final ProductPreferences productPreferences;

  @override
  List<Object?> get props => [productPreferences];
}

final class FoodPreferencePageLoadingFailure extends FoodPreferencePageState {
  FoodPreferencePageLoadingFailure({this.exception});

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
