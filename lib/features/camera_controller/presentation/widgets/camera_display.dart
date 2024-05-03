import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/camera_controller_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../text_recognition/presentation/bloc/text_recognition_bloc.dart';

class CameraDisplay extends StatefulWidget {
  const CameraDisplay({super.key, required this.cameraController});
  final CameraController cameraController;

  @override
  State<CameraDisplay> createState() => _CameraDisplayState();
}

class _CameraDisplayState extends State<CameraDisplay> {
  bool _isPermissionGranted = false;
  late final Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = _requestCameraPermission();
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
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: 100,
                          child: CameraPreview(widget.cameraController),
                        ),
                      ),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            Scaffold(
              backgroundColor: _isPermissionGranted ? Colors.transparent : null,
              body: _isPermissionGranted
                  ? Column(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: ElevatedButton(
                                onPressed: () => _takePicture(),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * .1),
                            Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: ElevatedButton(
                                onPressed: () => _recognitionTextFromGallery(),
                                child: const Icon(
                                  Icons.picture_in_picture,
                                  size: 40,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                        child: const Text(
                          'Camera permission denied',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissionGranted = status == PermissionStatus.granted;
  }

  Future<void> _takePicture() async {
    BlocProvider.of<CameraControllerBloc>(context).add(TakePicture());
  }

  Future<void> _recognitionTextFromGallery() async {
    BlocProvider.of<TextRecognitionBloc>(context)
        .add(TakeRecognizedTextFromGallery(context));
  }
}
