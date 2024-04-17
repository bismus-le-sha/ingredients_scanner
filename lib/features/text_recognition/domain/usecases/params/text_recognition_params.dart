import 'package:equatable/equatable.dart';

class TextRecognitionParams extends Equatable {
  final String path;

  const TextRecognitionParams({required this.path});

  @override
  List<Object?> get props => [path];
}
