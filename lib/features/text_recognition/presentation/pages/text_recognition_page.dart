import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/text_recognition/presentation/bloc/text_recognition_bloc.dart';

import '../../../../config/router/router.dart';
import '../../../other/page/home/camera/bloc/camera_controller_bloc.dart';
import '../../../other/page/home/camera/camera_widget.dart';

@RoutePage()
class TextRecognitionPage extends StatefulWidget {
  const TextRecognitionPage({super.key});

  @override
  State<TextRecognitionPage> createState() => _TextRecognitionPageState();
}

//TODO: Rewrite route
class _TextRecognitionPageState extends State<TextRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner Screen')),
      body: _buildBody(),
    );
  }

  MultiBlocListener _buildBody() {
    final bloc = BlocProvider.of<CameraControllerBloc>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<CameraControllerBloc, CameraControllerState>(
              listener: (context, state) {
            if (state is PictureFromCameraLoaded) {
              BlocProvider.of<TextRecognitionBloc>(context)
                  .add(TakeRecognizedTextFromCamera(state.picture.path));
            }
          }),
          BlocListener<TextRecognitionBloc, TextRecognitionState>(
            listener: (context, state) {
              if (state is TextRecognitionLoaded) {
                context.pushRoute(
                  ResultRoute(
                      textRecognitionEntity: state.textRecognitionEntity),
                );
              }
            },
          )
        ],
        child: BlocProvider(create: (_) {
          bloc.add(InitCamera());
          return bloc;
        }, child: BlocBuilder<CameraControllerBloc, CameraControllerState>(
            builder: (context, state) {
          if (state is CameraControllerLoaded) {
            return CameraWidget(
              cameraController: state.cameraController,
            );
          }
          if (state is CameraControllerFailure) {
            return Text(state.message);
          }
          return Container();
        })));
  }
}
