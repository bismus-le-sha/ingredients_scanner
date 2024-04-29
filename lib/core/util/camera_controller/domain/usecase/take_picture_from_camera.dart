import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';
import 'package:ingredients_scanner/core/usecase/usecase.dart';
import 'package:ingredients_scanner/core/util/camera_controller/domain/repository/camera_controller_repository.dart';

class TakePictureFromCamera extends UseCase<XFile, NoParams> {
  final CameraControllerRepository repository;

  TakePictureFromCamera(this.repository);

  @override
  Future<Either<Failure, XFile>> call(NoParams params) {
    return repository.takePictureFromCamera();
  }
}
