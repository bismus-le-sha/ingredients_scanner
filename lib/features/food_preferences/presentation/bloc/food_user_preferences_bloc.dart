import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_user_preferences_event.dart';
part 'food_user_preferences_state.dart';

class FoodUserPreferencesBloc extends Bloc<FoodUserPreferencesEvent, FoodUserPreferencesState> {
  FoodUserPreferencesBloc() : super(FoodUserPreferencesInitial()) {
    on<FoodUserPreferencesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
