import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/camera_controller/presentation/widgets/camera_display_controller.dart';
import 'package:ingredients_scanner/features/user_preferences/data/models/user_preferences_model.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../text_recognition/presentation/bloc/text_recognition_bloc.dart';

import '../../../../config/router/router.dart';
import '../bloc/camera_controller_bloc.dart';

@RoutePage()
class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late UserPreferencesModel userPreferencesModel;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserPreferencesBloc>(context)
        .add(const UserPreferencesLoad());
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
          BlocListener<CameraControllerBloc, CameraControllerState>(
              listener: (context, state) {
            if (state is PictureFromCameraLoaded) {
              textRecognitionBloc
                  .add(TakeRecognizedTextFromCamera(state.picture.path));
            }
            if (state is CameraControllerChangeFlash) {
              userPreferencesBloc.add(ChangeUserPreferences(userPreferencesModel
                  .copyWith(cameraFlash: !userPreferencesModel.cameraFlash)));
              userPreferencesBloc.add(const UserPreferencesLoad());
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
                    .then((result) => cameraBloc.add(InitCamera(
                        cameraFlashValue: userPreferencesModel.cameraFlash)));
                cameraBloc.add(DisposeCamera());
              }
            },
          )
        ],
        child: BlocBuilder<UserPreferencesBloc, UserPreferencesState>(
            builder: (context, state) {
          if (state is UserPreferencesLoaded) {
            userPreferencesModel =
                state.userPreferences as UserPreferencesModel;
            return CameraDisplayController(
                cameraFlash: userPreferencesModel.cameraFlash);
          }
          return const Center(
            child: LoadingWidget(),
          );
        }));
  }
}
