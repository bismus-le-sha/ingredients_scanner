import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

abstract class CameraControllerDataSource {
  Future<CameraController> initCameraController(bool cameraFlashValue);
  Future<XFile> takePictureFromCamera();
  Future<Unit> disposeCameraController();
  Future<Unit> controllCameraFlash(bool cameraFlashValue);
}

//TODO: Add cameraSelector
class CameraControllerDataSourceImpl implements CameraControllerDataSource {
  final List<CameraDescription> cameras;
  late CameraController cameraController;

  CameraControllerDataSourceImpl({
    required this.cameras,
  });

  @override
  Future<CameraController> initCameraController(bool cameraFlashValue) {
    return _initCamera(cameras[0], cameraFlashValue);
  }

  @override
  Future<XFile> takePictureFromCamera() async {
    if (!cameraController.value.isTakingPicture &&
        cameraController.value.isInitialized) {
      return await cameraController.takePicture();
    } else {
      throw CameraException('fail', 'fail');
    }
  }

  @override
  Future<Unit> disposeCameraController() {
    cameraController.dispose();
    return Future.value(unit);
  }

  Future<CameraController> _initCamera(
      CameraDescription camera, bool cameraFlashValue) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await cameraController.initialize();
    await controllCameraFlash(cameraFlashValue);
    return cameraController;
  }

  @override
  Future<Unit> controllCameraFlash(bool value) async {
    if (value) {
      await cameraController.setFlashMode(FlashMode.always);
      return Future.value(unit);
    } else {
      await cameraController.setFlashMode(FlashMode.off);
      return Future.value(unit);
    }
  }

  // void _selectCamera(List<CameraDescription> cameras) {
  //   CameraDescription? camera;
  //   for (var i = 0; i < cameras.length; i++) {
  //     final CameraDescription current = cameras[i];
  //     if (current.lensDirection == CameraLensDirection.back) {
  //       camera = current;
  //       break;
  //     }
  //   }

  //   if (camera != null) {
  //     _initCamera(camera);
  //   }
  // }
}
