import 'package:flutter/material.dart';

class PermissonDeniedDisplay extends StatelessWidget {
  const PermissonDeniedDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: const Text(
          'Camera permission denied',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
