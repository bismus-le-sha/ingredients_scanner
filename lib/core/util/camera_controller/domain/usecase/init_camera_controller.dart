import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/core/util/camera_controller/domain/repository/camera_controller_repository.dart';

class InitCameraController extends UseCase<CameraController, NoParams> {
  final CameraControllerRepository repository;

  InitCameraController(this.repository);

  @override
  Future<Either<Failure, CameraController>> call(NoParams params) {
    return repository.initCameraController();
  }
}
