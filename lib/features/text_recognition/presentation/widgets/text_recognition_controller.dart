import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/gallery_controller.dart';
import 'package:ingredients_scanner/features/text_recognition/presentation/bloc/text_recognition_bloc.dart';

class TextRecognitionController extends StatefulWidget {
  const TextRecognitionController({super.key});

  @override
  State<TextRecognitionController> createState() =>
      _TextRecognitionControllerState();
}

class _TextRecognitionControllerState extends State<TextRecognitionController> {
  final GalleryController galleryController = GallerycontrollerImpl();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 255, 255, .7),
        shape: const CircleBorder(),
        onPressed: () => _pickImage(),
        child: const Icon(
          Icons.camera_alt,
          size: 40,
          color: Colors.black87,
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final file = await galleryController.getImage(context: context);
    return file.fold(
        (failure) => print('fail'), (file) => _recognitionText(file.path));
  }

  Future<void> _recognitionText(String path) async {
    BlocProvider.of<TextRecognitionBloc>(context).add(GerRecognizedText(path));
  }
}
