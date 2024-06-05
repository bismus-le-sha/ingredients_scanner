import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../user_data/presentation/bloc/user_data_bloc.dart';

@RoutePage()
class AuthNavigationPage extends StatelessWidget {
  const AuthNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<UserDataBloc>(), child: const AutoRouter());
  }
}
