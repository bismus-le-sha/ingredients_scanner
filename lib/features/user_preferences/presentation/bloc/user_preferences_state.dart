part of 'user_preferences_bloc.dart';

abstract class UserPreferencesState extends Equatable {
  const UserPreferencesState();

  @override
  List<Object?> get props => [];
}

class UserPreferencesInitial extends UserPreferencesState {}

class UserPreferencesLoading extends UserPreferencesState {}

class UserPreferencesLoaded extends UserPreferencesState {
  final UserPreferencesEntity userPreferences;

  const UserPreferencesLoaded({
    required this.userPreferences,
  });

  @override
  List<Object?> get props => [userPreferences];
}

class UserPreferencesFailure extends UserPreferencesState {
  final String message;

  const UserPreferencesFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
