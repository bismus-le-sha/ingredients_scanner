import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_menu_screen_event.dart';
part 'user_menu_screen_state.dart';

class UserMenuScreenBloc extends Bloc<UserMenuScreenEvent, UserMenuScreenState> {
  UserMenuScreenBloc() : super(UserMenuScreenInitial()) {
    on<UserMenuScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
