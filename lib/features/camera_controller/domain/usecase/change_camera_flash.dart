import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/camera_controller_repository.dart';
import 'params/camera_params.dart';

class ChangeCameraFlash extends UseCase<Unit, CameraParams> {
  final CameraControllerRepository repository;

  ChangeCameraFlash(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CameraParams params) {
    return repository.changeCameraFlash(params.cameraFlashValue);
  }
}
