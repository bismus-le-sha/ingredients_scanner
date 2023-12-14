part of 'settings_screen_bloc.dart';

sealed class SettingsScreenState extends Equatable {
  const SettingsScreenState();
  
  @override
  List<Object> get props => [];
}

final class SettingsScreenInitial extends SettingsScreenState {}
