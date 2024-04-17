import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/text_recognition/presentation/bloc/text_recognition_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../widgets/recognized_text_display.dart';
import '../widgets/text_recognition_controller.dart';

@RoutePage()
class TextRecognitionPage extends StatefulWidget {
  const TextRecognitionPage({super.key});

  @override
  State<TextRecognitionPage> createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Scanner Screen')),
        body: SingleChildScrollView(child: _buildBody()));
  }

  BlocProvider<TextRecognitionBloc> _buildBody() {
    return BlocProvider(
      create: (_) => sl<TextRecognitionBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<TextRecognitionBloc, TextRecognitionState>(
                builder: (context, state) {
                  if (state is TextRecognitionInitial) {
                    return const Center(child: Text('no data'));
                  } else if (state is TextRecognitionLoading) {
                    return const LoadingWidget();
                  } else if (state is TextRecognitionLoaded) {
                    return RecognizedTextDisplay(
                      textRecognitionEntity: state.textRecognitionEntity,
                    );
                  } else if (state is TextRecognitionFailure) {}
                  return const Center(child: Text('bloc dont work'));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const TextRecognitionController()
            ],
          ),
        ),
      ),
    );
  }
}
