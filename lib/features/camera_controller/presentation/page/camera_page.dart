import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
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
  late bool cameraFlash;
  late UserPreferencesModel userPreferencesModel;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserPreferencesBloc>(context)
        .add(const UserPreferencesLoad());
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
      BlocProvider.of<CameraControllerBloc>(context)
          .add(InitCamera(cameraFlashValue: cameraFlash));
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
    final cameraBloc = BlocProvider.of<CameraControllerBloc>(context);
    final userPreferencesBloc = BlocProvider.of<UserPreferencesBloc>(context);
    final textRecognitionBloc = BlocProvider.of<TextRecognitionBloc>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<UserPreferencesBloc, UserPreferencesState>(
              listener: (context, state) {
            if (state is UserPreferencesLoaded) {
              cameraFlash = state.userPreferences.cameraFlash;
              cameraBloc.add(InitCamera(cameraFlashValue: cameraFlash));
              userPreferencesModel = UserPreferencesModel(
                  cameraFlash: cameraFlash,
                  useBiometrics: state.userPreferences.useBiometrics);
            }
          }),
          BlocListener<CameraControllerBloc, CameraControllerState>(
              listener: (context, state) {
            if (state is PictureFromCameraLoaded) {
              textRecognitionBloc
                  .add(TakeRecognizedTextFromCamera(state.picture.path));
            }
            if (state is CameraControllerChangeFlash) {
              userPreferencesBloc.add(ChangeUserPreferences(
                  userPreferencesModel.copyWith(cameraFlash: !cameraFlash)));
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
                    .then((result) => cameraBloc
                        .add(InitCamera(cameraFlashValue: cameraFlash)));
                cameraBloc.add(DisposeCamera());
              }
            },
          )
        ],
        child: BlocBuilder<CameraControllerBloc, CameraControllerState>(
            builder: (context, state) {
          if (state is CameraControllerLoaded) {
            return CameraDisplay(
              cameraController: state.cameraController,
              cameraFlash: cameraFlash,
            );
          }
          if (state is CameraControllerFailure) {
            return CameraFailureDisplay(
                onReload: () =>
                    userPreferencesBloc.add(const UserPreferencesLoad()),
                failureMessage: state.message);
          }
          return const Center(
            child: LoadingWidget(),
          );
        }));
  }
}
