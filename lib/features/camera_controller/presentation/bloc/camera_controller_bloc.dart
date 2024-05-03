import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecase/dispose_camera_controller.dart';
import '../../domain/usecase/init_camera_controller.dart';
import '../../domain/usecase/take_picture_from_camera.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../core/error/failures.dart';
import '../../../../injection_container.dart';

part 'camera_controller_event.dart';
part 'camera_controller_state.dart';

class CameraControllerBloc
    extends Bloc<CameraControllerEvent, CameraControllerState> {
  InitCameraController initCameraController;
  TakePictureFromCamera takePictureFromCamera;
  DisposeCameraController disposeCameraController;

  CameraControllerBloc(
      {required this.initCameraController,
      required this.takePictureFromCamera,
      required this.disposeCameraController})
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
    if (event is DisposeCamera) {
      final failureOrDisposeCamera = await disposeCameraController(NoParams());
      emit(_eitherUnitOrErrorState(failureOrDisposeCamera));
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

  CameraControllerState _eitherUnitOrErrorState(Either failureOrPicture) {
    return failureOrPicture.fold(
        (failure) =>
            CameraControllerFailure(message: _mapFailureToMessage(failure)),
        (unit) => CameraControllerDispose());
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
