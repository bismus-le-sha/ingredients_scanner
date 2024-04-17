part of 'text_recognition_bloc.dart';

abstract class TextRecognitionEvent extends Equatable {
  const TextRecognitionEvent();

  @override
  List<Object?> get props => [];
}

class GerRecognizedText extends TextRecognitionEvent {
  const GerRecognizedText(this.path);

  final String path;

  @override
  List<Object?> get props => [path];
}
