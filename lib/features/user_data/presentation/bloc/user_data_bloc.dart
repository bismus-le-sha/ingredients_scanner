import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ingredients_scanner/core/resources/failures_list.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/add_google_user_data.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/get_user_data.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/add_update_user_data.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../injection_container.dart';
import '../../data/models/user_data_model.dart';
import '../../domain/entities/user_data_entity.dart';
import '../../domain/usecases/params/user_data_params.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final GetUserData getUserData;
  final AddUpdateUserData addUpdateUserData;
  final AddGoogleUserData addGoogleUserData;

  UserDataBloc(
      {required this.getUserData,
      required this.addUpdateUserData,
      required this.addGoogleUserData})
      : super(UserDataInitial()) {
    on<UserDataEvent>((event, emit) => _userDataMapEventToState(event, emit));
  }

  Future<void> _userDataMapEventToState(
      UserDataEvent event, Emitter<UserDataState> emit) async {
    if (event is UserDataLoad) {
      try {
        final failureOrUserData = await getUserData(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrUserData));
      } finally {
        event.completer?.complete();
      }
    }
    if (event is AddChangeUserData) {
      final failureOrUnit =
          await addUpdateUserData(UserDataParams(userData: event.userData));
      emit(_eitherAddUpdateOrErrorState(failureOrUnit));
    }
    if (event is GoogleAddUserData) {
      final failureOrUnit = await addGoogleUserData(NoParams());
      emit(_eitherAddGoogleOrErrorState(failureOrUnit));
    }
  }

  UserDataState _eitherLoadedOrErrorState(Either failureOrUnit) {
    return failureOrUnit.fold(
        (failure) => UserDataFailure(message: _mapFailureToMessage(failure)),
        (userData) => UserDataLoaded(userData: userData));
  }

  UserDataState _eitherAddUpdateOrErrorState(
      Either failureOrUpdatedPreferences) {
    return failureOrUpdatedPreferences.fold(
        (failure) => UserDataFailure(message: _mapFailureToMessage(failure)),
        (unit) => UserDataAddedUpdated());
  }

  UserDataState _eitherAddGoogleOrErrorState(
      Either failureOrUpdatedPreferences) {
    return failureOrUpdatedPreferences.fold(
        (failure) => UserDataFailure(message: _mapFailureToMessage(failure)),
        (unit) => GoogleUserDataAdded());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DataNotFoundFailure():
        return DATA_NOT_FOUND_MESSAGE;
      case UserNotAuthenticatedFailure():
        return UNAUTHORISED_USER_MESSAGE;
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
