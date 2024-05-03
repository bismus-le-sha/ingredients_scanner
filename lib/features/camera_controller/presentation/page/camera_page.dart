import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../text_recognition/presentation/bloc/text_recognition_bloc.dart';
import '../widgets/camera_failure_display.dart';

import '../../../../config/router/router.dart';
import '../bloc/camera_controller_bloc.dart';
import '../widgets/camera_display.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CameraControllerBloc>(context).add(InitCamera());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      BlocProvider.of<CameraControllerBloc>(context).add(DisposeCamera());
    } else if (state == AppLifecycleState.resumed) {
      BlocProvider.of<CameraControllerBloc>(context).add(InitCamera());
    }
  }

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
                context
                    .pushRoute(
                      ResultRoute(
                          textRecognitionEntity: state.textRecognitionEntity),
                    )
                    .then((result) => bloc.add(InitCamera()));
                bloc.add(DisposeCamera());
              }
            },
          )
        ],
        child: BlocBuilder<CameraControllerBloc, CameraControllerState>(
            builder: (context, state) {
          if (state is CameraControllerLoaded) {
            return CameraDisplay(
              cameraController: state.cameraController,
            );
          }
          if (state is CameraControllerFailure) {
            return CameraFailureDisplay(
                onReload: () => bloc.add(InitCamera()),
                failureMessage: state.message);
          }
          return const Center(
            child: LoadingWidget(),
          );
        }));
  }
}
