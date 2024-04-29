import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/core/util/camera_controller/domain/usecase/init_camera_controller.dart';
import 'package:ingredients_scanner/core/util/camera_controller/domain/usecase/take_picture_from_camera.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../injection_container.dart';

part 'camera_controller_event.dart';
part 'camera_controller_state.dart';

class CameraControllerBloc
    extends Bloc<CameraControllerEvent, CameraControllerState> {
  InitCameraController initCameraController;
  TakePictureFromCamera takePictureFromCamera;

  CameraControllerBloc(
      {required this.initCameraController, required this.takePictureFromCamera})
      : super(CameraControllerInitial()) {
    on<CameraControllerEvent>(
        (event, emit) async => await _cameraMapEventToState(event, emit));
  }

  Future<void> _cameraMapEventToState(dynamic event, dynamic emit) async {
    if (event is InitCamera) {
      emit(CameraControllerLoading());
      final failureOrCameraController = await initCameraController(NoParams());
      emit(_eitherLoadedOrErrorState(failureOrCameraController));
    }
    if (event is TakePicture) {
      final failureOrPicture = await takePictureFromCamera(NoParams());
      emit(_eitherPictureOrErrorState(failureOrPicture));
    }
  }

  CameraControllerState _eitherLoadedOrErrorState(
      Either failureOrCameraController) {
    return failureOrCameraController.fold(
        (failure) =>
            CameraControllerFailure(message: _mapFailureToMessage(failure)),
        (cameraController) =>
            CameraControllerLoaded(cameraController: cameraController));
  }

  CameraControllerState _eitherPictureOrErrorState(Either failureOrPicture) {
    return failureOrPicture.fold(
        (failure) =>
            CameraControllerFailure(message: _mapFailureToMessage(failure)),
        (picture) => PictureFromCameraLoaded(picture: picture));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CameraFailure():
        return 'Camera faulure';
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
