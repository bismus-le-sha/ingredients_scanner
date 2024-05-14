import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import '../datasource/camera_controller_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repository/camera_controller_repository.dart';

class CameraControllerRepositoryImpl implements CameraControllerRepository {
  CameraControllerRepositoryImpl({required this.dataSource});
  final CameraControllerDataSource dataSource;

  @override
  Future<Either<Failure, CameraController>> initCameraController(
      bool cameraFlashValue) async {
    try {
      return Right(await dataSource.initCameraController(cameraFlashValue));
    } on CameraException {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, XFile>> takePictureFromCamera() async {
    try {
      return Right(await dataSource.takePictureFromCamera());
    } on CameraException {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> disposeCameraController() async {
    try {
      return Right(await dataSource.disposeCameraController());
    } on CameraException {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changeCameraFlash(bool cameraFlashValue) async {
    try {
      return Right(await dataSource.controllCameraFlash(cameraFlashValue));
    } on CameraException {
      return Left(CameraFailure());
    }
  }
}
