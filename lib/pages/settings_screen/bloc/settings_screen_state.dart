part of 'settings_screen_bloc.dart';

sealed class SettingsScreenState extends Equatable {}

final class SettingsScreenInitial extends SettingsScreenState {
  @override
  List<Object?> get props => [];
}

class SettingsScreenLoading extends SettingsScreenState {
  @override
  List<Object?> get props => [];
}

class SettingsScreenLoaded extends SettingsScreenState {
  SettingsScreenLoaded({
    required this.userPreferences,
  });

  final UserPreferences userPreferences;

  @override
  List<Object?> get props => [userPreferences];
}

class SettingsScreenLoadingFailure extends SettingsScreenState {
  SettingsScreenLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
