import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceCameraController {
  late CameraController cameraController;
  late Future<void> cameraValue;
  bool isFlashOn = false;
  bool isRearCamera = true;
  bool _isPermissionGranted = false;

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (cameraController != null) {
      _cameraSelected(cameraController!.description);
    }
  }

  void _stopCamera() {
    if (cameraController != null) {
      cameraController?.dispose();
    }
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (cameraController != null) {
      return;
    }

    // Select the first rear camera.
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    await cameraController!.initialize();
    await cameraController!.setFlashMode(FlashMode.off);

    // if (!mounted) {
    //   return;
    // }
    // setState(() {});
  }

  void dispose() {
    cameraController.dispose();
  }
}
