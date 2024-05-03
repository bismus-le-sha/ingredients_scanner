part of 'camera_controller_bloc.dart';

sealed class CameraControllerState extends Equatable {
  const CameraControllerState();

  @override
  List<Object?> get props => [];
}

final class CameraControllerInitial extends CameraControllerState {}

final class CameraControllerLoading extends CameraControllerState {}

final class CameraControllerLoaded extends CameraControllerState {
  final CameraController cameraController;

  const CameraControllerLoaded({required this.cameraController});

  @override
  List<Object?> get props => [cameraController];
}

final class PictureFromCameraLoaded extends CameraControllerState {
  final XFile picture;

  const PictureFromCameraLoaded({required this.picture});

  @override
  List<Object?> get props => [picture];
}

final class CameraControllerDispose extends CameraControllerState {}

final class CameraControllerFailure extends CameraControllerState {
  final String message;

  const CameraControllerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
