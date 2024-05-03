import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class CameraControllerRepository {
  Future<Either<Failure, CameraController>> initCameraController();
  Future<Either<Failure, XFile>> takePictureFromCamera();
  Future<Either<Failure, Unit>> disposeCameraController();
}
