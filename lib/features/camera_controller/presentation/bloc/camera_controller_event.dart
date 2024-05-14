part of 'camera_controller_bloc.dart';

sealed class CameraControllerEvent extends Equatable {
  const CameraControllerEvent();

  @override
  List<Object?> get props => [];
}

class InitCamera extends CameraControllerEvent {
  final bool cameraFlashValue;

  const InitCamera({required this.cameraFlashValue});

  @override
  List<Object?> get props => [cameraFlashValue];
}

class TakePicture extends CameraControllerEvent {}

class DisposeCamera extends CameraControllerEvent {}

class SwitchCameraFlash extends CameraControllerEvent {
  final bool cameraFlashValue;

  const SwitchCameraFlash({
    required this.cameraFlashValue,
  });

  @override
  List<Object?> get props => [cameraFlashValue];
}
