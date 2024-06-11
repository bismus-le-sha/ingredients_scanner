import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/camera_controller/presentation/widgets/camera_display.dart';
import 'package:ingredients_scanner/features/camera_controller/presentation/widgets/permisson_denied_display.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/camera_controller_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../text_recognition/presentation/bloc/text_recognition/text_recognition_bloc.dart';
import 'camera_failure_display.dart';

class CameraDisplayController extends StatefulWidget {
  const CameraDisplayController({super.key, required this.cameraFlash});
  final bool cameraFlash;

  @override
  State<CameraDisplayController> createState() => _CameraDisplayState();
}

class _CameraDisplayState extends State<CameraDisplayController>
    with WidgetsBindingObserver {
  bool _isPermissionGranted = false;
  late final Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = _requestCameraPermission();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_isPermissionGranted) {
      if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        BlocProvider.of<CameraControllerBloc>(context).add(DisposeCamera());
      } else if (state == AppLifecycleState.resumed) {
        BlocProvider.of<CameraControllerBloc>(context)
            .add(InitCamera(cameraFlashValue: widget.cameraFlash));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissionGranted)
              BlocConsumer<CameraControllerBloc, CameraControllerState>(
                  listener: (context, state) {
                if (state is CameraControllerChangeFlash) {
                  BlocProvider.of<CameraControllerBloc>(context)
                      .add(InitCamera(cameraFlashValue: widget.cameraFlash));
                }
              }, builder: (context, state) {
                if (state is CameraControllerLoaded) {
                  return CameraDisplay(
                      cameraController: state.cameraController);
                }
                if (state is CameraControllerFailure) {
                  return CameraFailureDisplay(
                      onReload: () =>
                          BlocProvider.of<CameraControllerBloc>(context).add(
                              InitCamera(cameraFlashValue: widget.cameraFlash)),
                      failureMessage: state.message);
                }
                return const Center(
                  child: LoadingWidget(),
                );
              }),
            Scaffold(
                backgroundColor:
                    _isPermissionGranted ? Colors.transparent : null,
                body: _isPermissionGranted
                    ? _cameraFlashButton()
                    : const PermissonDeniedDisplay()),
            _isPermissionGranted
                ? _cameraAndGalleryButtons(size)
                : _galleryButtons(size)
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
    if (_isPermissionGranted) {
      BlocProvider.of<CameraControllerBloc>(context)
          .add(InitCamera(cameraFlashValue: widget.cameraFlash));
    }
  }

  Future<void> _takePicture() async {
    BlocProvider.of<CameraControllerBloc>(context).add(TakePicture());
  }

  Future<void> _changeCameraFlash(bool cameraFlash) async {
    BlocProvider.of<CameraControllerBloc>(context)
        .add(SwitchCameraFlash(cameraFlashValue: cameraFlash));
  }

  Future<void> _recognitionTextFromGallery() async {
    BlocProvider.of<TextRecognitionBloc>(context)
        .add(TakeRecognizedTextFromGallery(context));
  }

  Widget _cameraFlashButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => _changeCameraFlash(!widget.cameraFlash),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 0, 0, 0),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: widget.cameraFlash
                    ? const Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 30,
                      )
                    : const Icon(
                        Icons.flash_off,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _cameraAndGalleryButtons(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _takePicture(),
              child: const Icon(
                Icons.camera_alt,
                size: 40,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: size.width * .1),
            ElevatedButton(
              onPressed: () => _recognitionTextFromGallery(),
              child: const Icon(
                Icons.picture_in_picture,
                size: 40,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _galleryButtons(Size size) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _recognitionTextFromGallery(),
              child: const Icon(
                Icons.picture_in_picture,
                size: 40,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
