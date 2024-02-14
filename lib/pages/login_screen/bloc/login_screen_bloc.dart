import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:ingredients_scanner/models/settings/user_pereference.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<LoadUserData>(_load);
  }

  Future<void> _load(
    LoadUserData event,
    Emitter<LoginScreenState> emit,
  ) async {
    try {
      if (state is! UserDataLoaded) {
        emit(UserDataLoading());
      }
      final preferences = await UserPreferences.getUserPreferences();
      emit(UserDataLoaded(preferences: preferences));
    } catch (e, st) {
      emit(UserDataLoadingFailure(exception: e));
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
