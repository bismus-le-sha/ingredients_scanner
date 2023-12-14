import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hello_screen_event.dart';
part 'hello_screen_state.dart';

class HelloScreenBloc extends Bloc<HelloScreenEvent, HelloScreenState> {
  HelloScreenBloc() : super(HelloScreenInitial()) {
    on<HelloScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
