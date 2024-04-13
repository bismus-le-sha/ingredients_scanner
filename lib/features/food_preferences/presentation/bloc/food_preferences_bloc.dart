import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/food_preferences_model.dart';
import '../../domain/entities/food_preferences_entity.dart';
import '../../domain/usecases/get_food_preferences_usecase.dart';
import '../../domain/usecases/params/food_preferences_params.dart';
import '../../domain/usecases/update_food_preferences.dart';
import '../../../../injection_container.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';

part 'food_preferences_event.dart';
part 'food_preferences_state.dart';

class FoodPreferencesBloc
    extends Bloc<FoodPreferencesEvent, FoodPreferencesState> {
  final GetFoodPreferences getFoodPreferences;
  final UpdateFoodPreferences updateFoodPreferences;

  FoodPreferencesBloc(
      {required this.getFoodPreferences, required this.updateFoodPreferences})
      : super(FoodPreferencesInitial()) {
    on<FoodPreferencesEvent>(
        (event, emit) => _foodPreferncesMapEventToState(event, emit));
  }

  Future<void> _foodPreferncesMapEventToState(
      dynamic event, dynamic emit) async {
    if (event is FoodPreferencesLoad) {
      try {
        final failureOrPreferences = await getFoodPreferences(NoParams());
        emit(_eitherLoadedOrErrorState(failureOrPreferences));
      } finally {
        event.completer?.complete();
      }
    }
    if (event is ChangeFoodPreferences) {
      final failureOrPreferences = await updateFoodPreferences(
          FoodPreferencesParams(foodPreferencesModel: event.foodPreferences));
      emit(_eitherUpdateOrErrorState(failureOrPreferences));
      add(const FoodPreferencesLoad());
    }
  }

  FoodPreferencesState _eitherLoadedOrErrorState(Either failureOrPreferences) {
    return failureOrPreferences.fold(
        (failure) =>
            FoodPreferencesFailure(message: _mapFailureToMessage(failure)),
        (foodPreferences) =>
            FoodPreferencesLoaded(foodPreferences: foodPreferences));
  }

  FoodPreferencesState _eitherUpdateOrErrorState(
      Either failureOrUpdatedPreferences) {
    return failureOrUpdatedPreferences.fold(
        (failure) =>
            FoodPreferencesFailure(message: _mapFailureToMessage(failure)),
        (unit) => FoodPreferencesLoading());
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
