part of 'login_screen_bloc.dart';

sealed class LoginScreenEvent extends Equatable {}

class LoadUserData extends LoginScreenEvent {
  LoadUserData({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
