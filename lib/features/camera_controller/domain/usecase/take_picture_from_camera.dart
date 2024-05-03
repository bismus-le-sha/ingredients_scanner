import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/camera_controller_repository.dart';

class TakePictureFromCamera extends UseCase<XFile, NoParams> {
  final CameraControllerRepository repository;

  TakePictureFromCamera(this.repository);

  @override
  Future<Either<Failure, XFile>> call(NoParams params) {
    return repository.takePictureFromCamera();
  }
}
