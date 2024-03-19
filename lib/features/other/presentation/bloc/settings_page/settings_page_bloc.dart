import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../domain/models/settings/user_pereference.dart';

part 'settings_page_event.dart';
part 'settings_page_state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  SettingsPageBloc() : super(SettingsPageInitial()) {
    on<LoadSettingPage>(_load);
  }

  Future<void> _load(
    LoadSettingPage event,
    Emitter<SettingsPageState> emit,
  ) async {
    try {
      if (state is! SettingsPageLoaded) {
        emit(SettingsPageLoading());
      }
      final preferences = await UserPreferences.getUserPreferences();
      emit(SettingsPageLoaded(userPreferences: preferences));
    } catch (e, st) {
      emit(SettingsPageLoadingFailure(exception: e));
      GetIt.I<Talker>().handle(e, st);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
