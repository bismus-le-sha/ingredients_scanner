part of 'settings_page_bloc.dart';

sealed class SettingsPageEvent extends Equatable {}

class LoadSettingPage extends SettingsPageEvent {
  LoadSettingPage({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
