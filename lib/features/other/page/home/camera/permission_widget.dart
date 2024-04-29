// import 'package:flutter/widgets.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PermissionWidget extends StatelessWidget {
//    PermissionWidget({super.key});
//     bool _isPermissionGranted = false;

//   @override
//   Widget build(BuildContext context) {
//     return _requestCameraPermission();
//   }

//     Future<void> _requestCameraPermission() async {
//     final status = await Permission.camera.request();
//     _isPermissionGranted = status == PermissionStatus.granted;
//   }
// }