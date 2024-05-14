import 'package:equatable/equatable.dart';

class CameraParams extends Equatable {
  final bool cameraFlashValue;

  const CameraParams({required this.cameraFlashValue});

  @override
  List<Object?> get props => [cameraFlashValue];
}
