import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FailureMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const FailureMessage(
      {super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(message),
            const Text('Please try again'),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Iconsax.refresh),
            )
          ],
        ),
      ),
    );
  }
}
