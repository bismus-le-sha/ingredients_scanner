part of 'sign_page_bloc.dart';

sealed class SignInPageEvent extends Equatable {}

class LoadUserData extends SignInPageEvent {
  LoadUserData({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
