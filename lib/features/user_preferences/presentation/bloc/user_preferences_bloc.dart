import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/entities/user_preferences_entity.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/get_user_preference.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/params/user_preferences_params.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/update_camera_flash.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/update_use_biometrics.dart';
import 'package:ingredients_scanner/injection_container.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';

part 'user_preferences_event.dart';
part 'user_preferences_state.dart';

class UserPreferencesBloc
    extends Bloc<UserPreferencesEvent, UserPreferencesState> {
  GetUserPreferences getUserPreferences;
  UpdateCameraFlash updateCameraFlash;
  UpdateUseBiometrics updateUseBiometrics;

  UserPreferencesBloc(
      {required this.getUserPreferences,
      required this.updateCameraFlash,
      required this.updateUseBiometrics})
      : super(UserPreferencesInitial()) {
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
    if (event is ChangeCameraFlash || event is ChangeUseBiometrics) {
      switch (event.runtimeType) {
        case const (ChangeCameraFlash):
          final failureOrUpdatedPreferences = await updateCameraFlash(
              UserPreferencesParams(value: event.value));
          emit(_eitherUpdateOrErrorState(failureOrUpdatedPreferences));
          break;
        case const (ChangeUseBiometrics):
          final failureOrUpdatedPreferences = await updateUseBiometrics(
              UserPreferencesParams(value: event.value));
          emit(_eitherUpdateOrErrorState(failureOrUpdatedPreferences));
      }
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
