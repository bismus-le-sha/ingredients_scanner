part of 'settings_page_bloc.dart';

sealed class SettingsPageState extends Equatable {}

final class SettingsPageInitial extends SettingsPageState {
  @override
  List<Object?> get props => [];
}

class SettingsPageLoading extends SettingsPageState {
  @override
  List<Object?> get props => [];
}

class SettingsPageLoaded extends SettingsPageState {
  SettingsPageLoaded({
    required this.userPreferences,
  });

  final UserPreferences userPreferences;

  @override
  List<Object?> get props => [userPreferences];
}

class SettingsPageLoadingFailure extends SettingsPageState {
  SettingsPageLoadingFailure({
    this.exception,
  });

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
