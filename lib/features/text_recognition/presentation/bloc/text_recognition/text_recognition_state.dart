part of 'text_recognition_bloc.dart';

abstract class TextRecognitionState extends Equatable {
  const TextRecognitionState();

  @override
  List<Object?> get props => [];
}

class TextRecognitionInitial extends TextRecognitionState {}

class TextRecognitionLoading extends TextRecognitionState {}

class TextRecognitionLoaded extends TextRecognitionState {
  final TextRecognitionEntity textRecognitionEntity;

  const TextRecognitionLoaded({required this.textRecognitionEntity});

  @override
  List<Object?> get props => [textRecognitionEntity];
}

class TextRecognitionFailure extends TextRecognitionState {
  final String message;

  const TextRecognitionFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
