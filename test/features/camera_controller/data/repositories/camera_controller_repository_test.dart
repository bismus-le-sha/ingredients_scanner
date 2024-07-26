// import 'package:camera/camera.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ingredients_scanner/features/camera_controller/data/repository/camera_controller_repository_impl.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// @GenerateMocks([CameraController])
// void main() {
//   late CameraControllerRepositoryImpl repository;
//   late MockCameraController mockCameraController;
//   late CameraDescription mockCameraDescription;

//   setUp(() {
//     mockCameraController = MockCameraController();
//     mockCameraDescription = CameraDescription(
//       name: 'Test Camera',
//       lensDirection: CameraLensDirection.back,
//       sensorOrientation: 90,
//     );
//     repository = CameraControllerRepositoryImpl(
//       cameras: [mockCameraDescription],
//     );
//     repository.cameraController = mockCameraController;
//   });

//   group('initCameraController', () {
//     test('should initialize the camera controller with the correct settings',
//         () async {
//       when(mockCameraController.initialize()).thenAnswer((_) async {});
//       when(mockCameraController.setFlashMode(any)).thenAnswer((_) async {});

//       await repository.initCameraController(true);

//       verify(mockCameraController.initialize()).called(1);
//       verify(mockCameraController.setFlashMode(FlashMode.always)).called(1);
//     });
//   });

//   group('takePictureFromCamera', () {
//     test(
//         'should take a picture when camera is initialized and not taking picture',
//         () async {
//       when(mockCameraController.value).thenReturn(CameraValue(
//         isInitialized: true,
//         isTakingPicture: false,
//       ));
//       final xfile = XFile('path/to/file');
//       when(mockCameraController.takePicture()).thenAnswer((_) async => xfile);

//       final result = await repository.takePictureFromCamera();

//       expect(result, equals(xfile));
//       verify(mockCameraController.takePicture()).called(1);
//     });

//     test(
//         'should throw CameraException when camera is not initialized or taking picture',
//         () async {
//       when(mockCameraController.value).thenReturn(CameraValue(
//         isInitialized: false,
//         isTakingPicture: false,
//       ));

//       expect(
//         () => repository.takePictureFromCamera(),
//         throwsA(isA<CameraException>()),
//       );
//     });
//   });

//   group('disposeCameraController', () {
//     test('should dispose the camera controller', () async {
//       when(mockCameraController.dispose()).thenAnswer((_) async {});

//       await repository.disposeCameraController();

//       verify(mockCameraController.dispose()).called(1);
//     });
//   });

//   group('controllCameraFlash', () {
//     test('should set flash mode to always when value is true', () async {
//       when(mockCameraController.setFlashMode(FlashMode.always))
//           .thenAnswer((_) async {});

//       await repository.controllCameraFlash(true);

//       verify(mockCameraController.setFlashMode(FlashMode.always)).called(1);
//     });

//     test('should set flash mode to off when value is false', () async {
//       when(mockCameraController.setFlashMode(FlashMode.off))
//           .thenAnswer((_) async {});

//       await repository.controllCameraFlash(false);

//       verify(mockCameraController.setFlashMode(FlashMode.off)).called(1);
//     });
//   });
// }
