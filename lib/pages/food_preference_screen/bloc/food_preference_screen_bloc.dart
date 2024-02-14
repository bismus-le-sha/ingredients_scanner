import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ingredients_scanner/models/product_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'food_preference_screen_event.dart';
part 'food_preference_screen_state.dart';

class FoodPreferenceScreenBloc
    extends Bloc<FoodPreferenceScreenEvent, FoodPreferenceScreenState> {
  FoodPreferenceScreenBloc() : super(FoodPreferenceScreenInitial()) {
    on<LoadFoodPreferenceScreen>(_load);
  }

  Future<void> _load(
    LoadFoodPreferenceScreen event,
    Emitter<FoodPreferenceScreenState> emit,
  ) async {
    try {
      if (state is! FoodPreferenceScreenLoaded) {
        emit(FoodPreferenceScreenLoading());
      }
      final preferencec = await ProductPreferences.getProductPreferences();
      emit(FoodPreferenceScreenLoaded(productPreferences: preferencec));
    } catch (e, st) {
      emit(FoodPreferenceScreenLoadingFailure(exception: e));
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
