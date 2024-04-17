import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/gallery_controller.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/entities/text_recognition_entity.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/usecases/params/text_recognition_params.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/get_recognized_text_usecase.dart';

part 'text_recognition_event.dart';
part 'text_recognition_state.dart';

class TextRecognitionBloc
    extends Bloc<TextRecognitionEvent, TextRecognitionState> {
  GetRecognizedText getRecognizedText;
  GalleryController galleryController;

  TextRecognitionBloc(
      {required this.getRecognizedText, required this.galleryController})
      : super(TextRecognitionInitial()) {
    on<TextRecognitionEvent>(
        (event, emit) => _textRecognizerMapEventToState(event, emit));
  }

  Future<void> _textRecognizerMapEventToState(
      dynamic event, dynamic emit) async {
    if (event is GerRecognizedText) {
      emit(TextRecognitionLoading());
      final failureOrRecognizedText =
          await getRecognizedText(TextRecognitionParams(path: event.path));
      emit(_eitherLoadedOrErrorState(failureOrRecognizedText));
    }
  }

  TextRecognitionState _eitherLoadedOrErrorState(Either failureOrPreferences) {
    return failureOrPreferences.fold(
        (failure) =>
            TextRecognitionFailure(message: _mapFailureToMessage(failure)),
        (textRecognitionModel) =>
            TextRecognitionLoaded(textRecognitionEntity: textRecognitionModel));
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
