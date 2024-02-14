part of 'settings_screen_bloc.dart';

sealed class SettingsScreenEvent extends Equatable {}

class LoadSettingScreen extends SettingsScreenEvent {
  LoadSettingScreen({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
