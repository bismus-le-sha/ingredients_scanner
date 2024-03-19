import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../other/domain/models/settings/user_pereference.dart';

part 'sign_page_event.dart';
part 'sign_page_state.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  SignInPageBloc() : super(LoginScreenInitial()) {
    on<LoadUserData>(_load);
  }

  Future<void> _load(
    LoadUserData event,
    Emitter<SignInPageState> emit,
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
