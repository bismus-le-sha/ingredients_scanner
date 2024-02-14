part of 'login_screen_bloc.dart';

sealed class LoginScreenState extends Equatable {}

final class LoginScreenInitial extends LoginScreenState {
  @override
  List<Object?> get props => [];
}

final class UserDataLoading extends LoginScreenState {
  @override
  List<Object?> get props => [];
}

class UserDataLoaded extends LoginScreenState {
  UserDataLoaded({required this.preferences});

  final UserPreferences preferences;

  @override
  List<Object?> get props => [preferences];
}

class UserDataLoadingFailure extends LoginScreenState {
  UserDataLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
