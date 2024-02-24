import 'package:flutter/material.dart';

class MessageSnackBar {
  SnackBar popUpSnackBar(message) {
    return SnackBar(
      content: Text(message),
      width: 350,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
