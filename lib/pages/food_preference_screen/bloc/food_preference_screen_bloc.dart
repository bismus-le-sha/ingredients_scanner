
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_preference_screen_event.dart';
part 'food_preference_screen_state.dart';

class FoodPreferenceScreenBloc
    extends Bloc<FoodPreferenceScreenEvent, FoodPreferenceScreenState> {
  FoodPreferenceScreenBloc() : super(FoodPreferenceScreenInitial()) {
    on<FoodPreferenceScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
