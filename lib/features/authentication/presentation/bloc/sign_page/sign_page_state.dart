part of 'sign_page_bloc.dart';

sealed class SignInPageState extends Equatable {}

final class LoginScreenInitial extends SignInPageState {
  @override
  List<Object?> get props => [];
}

final class UserDataLoading extends SignInPageState {
  @override
  List<Object?> get props => [];
}

class UserDataLoaded extends SignInPageState {
  UserDataLoaded({required this.preferences});

  final UserPreferences preferences;

  @override
  List<Object?> get props => [preferences];
}

class UserDataLoadingFailure extends SignInPageState {
  UserDataLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
