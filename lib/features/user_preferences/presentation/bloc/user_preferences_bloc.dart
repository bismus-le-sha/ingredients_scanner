import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/user_preferences_model.dart';
import '../../domain/entities/user_preferences_entity.dart';
import '../../domain/usecases/get_user_preference.dart';
import '../../domain/usecases/params/user_preferences_params.dart';
import '../../domain/usecases/update_user_preferences.dart';
import '../../../../injection_container.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';

part 'user_preferences_event.dart';
part 'user_preferences_state.dart';

class UserPreferencesBloc
    extends Bloc<UserPreferencesEvent, UserPreferencesState> {
  GetUserPreferences getUserPreferences;
  UpdateUserPreferences updateUserPreferences;

  UserPreferencesBloc({
    required this.getUserPreferences,
    required this.updateUserPreferences,
  }) : super(UserPreferencesInitial()) {
    on<UserPreferencesEvent>(
        (event, emit) => _userPreferencesMapEventToState(event, emit));
  }

  Future<void> _userPreferencesMapEventToState(
      dynamic event, dynamic emit) async {
    if (event is UserPreferencesLoad) {
      try {
        final failureOrPreferences = await getUserPreferences(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrPreferences));
      } finally {
        event.completer?.complete();
      }
    }
    if (event is ChangeUserPreferences) {
      final failureOrUpdatedPreferences = await updateUserPreferences(
          UserPreferencesParams(userPrefernces: event.value));
      emit(_eitherUpdateOrErrorState(failureOrUpdatedPreferences));

      add(const UserPreferencesLoad());
    }
  }

  UserPreferencesState _eitherLoadedOrErrorState(Either failureOrPreferences) {
    return failureOrPreferences.fold(
        (failure) =>
            UserPreferencesFailure(message: _mapFailureToMessage(failure)),
        (preferences) => UserPreferencesLoaded(userPreferences: preferences));
  }

  UserPreferencesState _eitherUpdateOrErrorState(
      Either failureOrUpdatedPreferences) {
    return failureOrUpdatedPreferences.fold(
        (failure) =>
            UserPreferencesFailure(message: _mapFailureToMessage(failure)),
        (unit) => UserPreferencesLoading());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure():
        return DATABASE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    sl<Talker>().handle(error, stackTrace);
  }
}
