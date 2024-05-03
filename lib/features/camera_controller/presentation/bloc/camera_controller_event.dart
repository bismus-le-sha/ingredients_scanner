part of 'camera_controller_bloc.dart';

sealed class CameraControllerEvent extends Equatable {
  const CameraControllerEvent();

  @override
  List<Object?> get props => [];
}

class InitCamera extends CameraControllerEvent {}

class TakePicture extends CameraControllerEvent {}

class DisposeCamera extends CameraControllerEvent {}

class ChangeCameraFalsh extends CameraControllerEvent {}
