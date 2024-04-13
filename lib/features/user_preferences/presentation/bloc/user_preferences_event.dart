part of 'user_preferences_bloc.dart';

abstract class UserPreferencesEvent extends Equatable {
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

class ChangeUserPreferences extends UserPreferencesEvent {
  final UserPreferencesModel value;

  const ChangeUserPreferences(this.value);

  @override
  List<Object?> get props => [value];
}
