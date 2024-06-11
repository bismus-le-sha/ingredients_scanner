import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../../core/util/gallery_controller/domain/usecases/params/gallery_controller_params.dart';
import '../../../domain/entities/text_recognition_entity.dart';
import '../../../domain/usecases/params/text_recognition_params.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/resources/failures_list.dart';
import '../../../../../injection_container.dart';
import '../../../../../core/util/gallery_controller/domain/usecases/get_from_gallery.dart';
import '../../../domain/usecases/get_recognized_text_usecase.dart';

part 'text_recognition_event.dart';
part 'text_recognition_state.dart';

class TextRecognitionBloc
    extends Bloc<TextRecognitionEvent, TextRecognitionState> {
  GetRecognizedText getRecognizedText;
  GetFromGallery getFromGallery;

  TextRecognitionBloc(
      {required this.getRecognizedText, required this.getFromGallery})
      : super(TextRecognitionInitial()) {
    on<TextRecognitionEvent>((event, emit) async =>
        await _textRecognizerMapEventToState(event, emit));
  }

  Future<void> _textRecognizerMapEventToState(
      TextRecognitionEvent event, Emitter<TextRecognitionState> emit) async {
    if (event is TakeRecognizedTextFromCamera) {
      emit(TextRecognitionLoading());
      final failureOrRecognizedText =
          await getRecognizedText(TextRecognitionParams(path: event.path));
      emit(_eitherLoadedOrErrorState(failureOrRecognizedText));
    }
    if (event is TakeRecognizedTextFromGallery) {
      emit(TextRecognitionLoading());
      final failureOrFile =
          await getFromGallery(GalleryControllerParams(context: event.context));
      await failureOrFile.fold(
          (failure) async =>
              TextRecognitionFailure(message: _mapFailureToMessage(failure)),
          (file) async {
        final failureOrRecognizedText =
            await getRecognizedText(TextRecognitionParams(path: file.path));
        emit(_eitherLoadedOrErrorState(failureOrRecognizedText));
      });
    }
  }

  TextRecognitionState _eitherLoadedOrErrorState(
      Either failureOrRecognizedText) {
    return failureOrRecognizedText.fold(
        (failure) =>
            TextRecognitionFailure(message: _mapFailureToMessage(failure)),
        (textRecognitionModel) =>
            TextRecognitionLoaded(textRecognitionEntity: textRecognitionModel));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (NoSuchFileFailure):
        return NO_SUCH_FILE_MESSAGE;
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
