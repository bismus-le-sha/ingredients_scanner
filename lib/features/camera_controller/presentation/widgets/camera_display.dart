import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraDisplay extends StatelessWidget {
  const CameraDisplay({super.key, required this.cameraController});
  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: 100,
          child: CameraPreview(cameraController),
        ),
      ),
    );
  }
}
