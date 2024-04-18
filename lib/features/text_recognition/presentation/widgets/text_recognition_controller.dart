import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/text_recognition/presentation/bloc/text_recognition_bloc.dart';

class TextRecognitionController extends StatefulWidget {
  const TextRecognitionController({super.key});

  @override
  State<TextRecognitionController> createState() =>
      _TextRecognitionControllerState();
}

class _TextRecognitionControllerState extends State<TextRecognitionController> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(255, 255, 255, .7),
      shape: const CircleBorder(),
      onPressed: () => _recognitionTextFromGallery(),
      child: const Icon(
        Icons.camera_alt,
        size: 40,
        color: Colors.black87,
      ),
    );
  }

  Future<void> _recognitionTextFromCamera(String path) async {
    BlocProvider.of<TextRecognitionBloc>(context)
        .add(TakeRecognizedTextFromCamera(path));
  }

  Future<void> _recognitionTextFromGallery() async {
    BlocProvider.of<TextRecognitionBloc>(context)
        .add(TakeRecognizedTextFromGallery(context));
  }
}
