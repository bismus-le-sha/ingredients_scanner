part of 'text_recognition_bloc.dart';

abstract class TextRecognitionEvent extends Equatable {
  const TextRecognitionEvent();

  @override
  List<Object?> get props => [];
}

class TakeRecognizedTextFromCamera extends TextRecognitionEvent {
  const TakeRecognizedTextFromCamera(this.path);

  final String path;

  @override
  List<Object?> get props => [path];
}

class TakeRecognizedTextFromGallery extends TextRecognitionEvent {
  const TakeRecognizedTextFromGallery(this.context);

  final BuildContext context;

  @override
  List<Object?> get props => [context];
}
