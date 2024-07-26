import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ingredients_scanner/features/camera_controller/data/datasource/camera_controller_data_source.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late CameraControllerDataSourceImpl dataSource;
  late MockCameraController mockCameraController;
  late CameraDescription cameraDescription;

  setUp(() {
    mockCameraController = MockCameraController();
    cameraDescription = const CameraDescription(
      name: 'Test Camera',
      lensDirection: CameraLensDirection.back,
      sensorOrientation: 90,
    );
    dataSource = CameraControllerDataSourceImpl(
      cameras: [cameraDescription],
    );
  });

  group('initCameraController', () {
    test('should initialize the camera controller with the correct settings',
        () async {
      when(mockCameraController.initialize()).thenAnswer((_) async {});
      when(mockCameraController.setFlashMode(any)).thenAnswer((_) async {});

      await dataSource.initCameraController(true);

      verify(mockCameraController.initialize()).called(1);
      verify(mockCameraController.setFlashMode(FlashMode.always)).called(1);
    });
  });

  // group('takePictureFromCamera', () {
  //   test(
  //       'should take a picture when camera is initialized and not taking picture',
  //       () async {
  //     when(mockCameraController.value).thenReturn(CameraValue(
  //       isInitialized: true,
  //       isTakingPicture: false,
  //     ));
  //     final xfile = XFile('path/to/file');
  //     when(mockCameraController.takePicture()).thenAnswer((_) async => xfile);

  //     final result = await dataSource.takePictureFromCamera();

  //     expect(result, equals(xfile));
  //     verify(mockCameraController.takePicture()).called(1);
  //   });

  //   test(
  //       'should throw CameraException when camera is not initialized or taking picture',
  //       () async {
  //     when(mockCameraController.value).thenReturn(CameraValue(
  //       isInitialized: false,
  //       isTakingPicture: false,
  //     ));

  //     expect(
  //       () => dataSource.takePictureFromCamera(),
  //       throwsA(isA<CameraException>()),
  //     );
  //   });
  // });

  group('disposeCameraController', () {
    test('should dispose the camera controller', () async {
      dataSource.disposeCameraController();

      verify(mockCameraController.dispose()).called(1);
    });
  });

  group('controllCameraFlash', () {
    test('should set flash mode to always when value is true', () async {
      when(mockCameraController.setFlashMode(FlashMode.always))
          .thenAnswer((_) async {});

      await dataSource.controllCameraFlash(true);

      verify(mockCameraController.setFlashMode(FlashMode.always)).called(1);
    });

    test('should set flash mode to off when value is false', () async {
      when(mockCameraController.setFlashMode(FlashMode.off))
          .thenAnswer((_) async {});

      await dataSource.controllCameraFlash(false);

      verify(mockCameraController.setFlashMode(FlashMode.off)).called(1);
    });
  });
}
