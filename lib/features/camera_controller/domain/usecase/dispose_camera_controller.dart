import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/camera_controller_repository.dart';

class DisposeCameraController extends UseCase<Unit, NoParams> {
  final CameraControllerRepository repository;

  DisposeCameraController(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.disposeCameraController();
  }
}
