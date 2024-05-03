import 'package:flutter/material.dart';

class CameraFailureDisplay extends StatelessWidget {
  final VoidCallback onReload;
  final String failureMessage;

  const CameraFailureDisplay(
      {super.key, required this.onReload, required this.failureMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(failureMessage),
          TextButton(
            onPressed: onReload,
            child: const Text('Try againg'),
          ),
        ],
      ),
    );
  }
}
