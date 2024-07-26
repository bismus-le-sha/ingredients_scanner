import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/add_update_user_data.dart';
import 'package:ingredients_scanner/features/user_data/presentation/bloc/user_data_bloc.dart';
import 'package:ingredients_scanner/features/user_data/presentation/widgets/auth_profile_display.dart';
import 'package:ingredients_scanner/features/user_data/presentation/widgets/guest_profile_display.dart';

import '../../../../../config/router/router.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoggedOutState) {
                context.replaceRoute(const AuthNavigationRoute());
              }
            },
          ),
          BlocListener<UserDataBloc, UserDataState>(
            listener: (context, state) {
              if (state is AddUpdateUserData) {
                BlocProvider.of<UserDataBloc>(context)
                    .add(const UserDataLoad());
              }
            },
          ),
        ],
        child: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoaded) {
              return AuthProfileDisplay(userData: state.userData);
            }
            if (state is UserDataFailure) {}
            return const GuestProfileDisplay();
          },
        ));
  }
}
