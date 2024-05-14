import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/camera_controller_repository.dart';
import 'params/camera_params.dart';

class InitCameraController extends UseCase<CameraController, CameraParams> {
  final CameraControllerRepository repository;

  InitCameraController(this.repository);

  @override
  Future<Either<Failure, CameraController>> call(CameraParams params) {
    return repository.initCameraController(params.cameraFlashValue);
  }
}
