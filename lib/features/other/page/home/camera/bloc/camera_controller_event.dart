part of 'camera_controller_bloc.dart';

sealed class CameraControllerEvent extends Equatable {
  const CameraControllerEvent();

  @override
  List<Object?> get props => [];
}

class InitCamera extends CameraControllerEvent {
  // const InitCamera(this.cameras);

  // final List<CameraDescription> cameras;

  // @override
  // List<Object?> get props => [cameras];
}

class TakePicture extends CameraControllerEvent {}

class ChangeCameraFalsh extends CameraControllerEvent {}
