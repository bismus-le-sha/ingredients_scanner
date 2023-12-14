import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_screen_event.dart';
part 'settings_screen_state.dart';

class SettingsScreenBloc extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  SettingsScreenBloc() : super(SettingsScreenInitial()) {
    on<SettingsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
