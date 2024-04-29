import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:ingredients_scanner/core/error/failures.dart';

abstract class CameraControllerRepository {
  Future<Either<Failure, CameraController>> initCameraController();
  Future<Either<Failure, XFile>> takePictureFromCamera();
}
