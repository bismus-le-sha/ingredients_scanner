import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../domain/models/product_preferences.dart';

part 'food_preference_page_event.dart';
part 'food_preference_page_state.dart';

class FoodPreferencePageBloc
    extends Bloc<FoodPreferencePageEvent, FoodPreferencePageState> {
  FoodPreferencePageBloc() : super(FoodPreferencePageInitial()) {
    on<LoadFoodPreferencePage>(_load);
  }

  Future<void> _load(
    LoadFoodPreferencePage event,
    Emitter<FoodPreferencePageState> emit,
  ) async {
    try {
      if (state is! FoodPreferencePageLoaded) {
        emit(FoodPreferencePageLoading());
      }
      final preferencec = await ProductPreferences.getProductPreferences();
      emit(FoodPreferencePageLoaded(productPreferences: preferencec));
    } catch (e, st) {
      emit(FoodPreferencePageLoadingFailure(exception: e));
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
