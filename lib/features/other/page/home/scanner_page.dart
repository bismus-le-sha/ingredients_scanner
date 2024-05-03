import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../camera_controller/presentation/bloc/camera_controller_bloc.dart';

import '../../../../injection_container.dart';
import '../../../text_recognition/presentation/bloc/text_recognition_bloc.dart';

@RoutePage()
class ScannerNavigationPage extends StatelessWidget {
  const ScannerNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => sl<TextRecognitionBloc>()),
      BlocProvider(create: (_) => sl<CameraControllerBloc>())
    ], child: const AutoRouter());
  }
}
