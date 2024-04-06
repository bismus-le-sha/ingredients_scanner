part of 'user_preferences_bloc.dart';

sealed class UserPreferencesEvent extends Equatable {
  const UserPreferencesEvent();

  @override
  List<Object?> get props => [];
}

class UserPreferencesLoad extends UserPreferencesEvent {
  const UserPreferencesLoad({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class ChangeCameraFlash extends UserPreferencesEvent {
  final bool value;

  const ChangeCameraFlash(this.value);

  @override
  List<Object?> get props => [value];
}

class ChangeUseBiometrics extends UserPreferencesEvent {
  final bool value;

  const ChangeUseBiometrics(this.value);

  @override
  List<Object?> get props => [value];
}
