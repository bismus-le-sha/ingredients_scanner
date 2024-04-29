import 'package:camera/camera.dart';

abstract class CameraControllerDataSource {
  Future<CameraController> initCameraController();
  Future<XFile> takePictureFromCamera();
}

//TODO: Add cameraFlash controller and cameraSelector
class CameraControllerDataSourceImpl implements CameraControllerDataSource {
  final List<CameraDescription> cameras;
  late CameraController cameraController;

  CameraControllerDataSourceImpl({
    required this.cameras,
  });

  @override
  Future<CameraController> initCameraController() {
    return _initCamera(cameras[0]);
  }

  @override
  Future<XFile> takePictureFromCamera() async {
    if (!cameraController.value.isTakingPicture ||
        cameraController.value.isInitialized) {
      return await cameraController.takePicture();
    } else {
      throw CameraException('fail', 'fail');
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

  Future<CameraController> _initCamera(CameraDescription camera) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await cameraController.initialize();
    await cameraController.setFlashMode(FlashMode.off);
    return cameraController;
  }
}
