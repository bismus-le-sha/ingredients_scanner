import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/add_update_user_data.dart';
import 'package:ingredients_scanner/features/user_data/presentation/bloc/user_data_bloc.dart';
import 'package:ingredients_scanner/features/user_data/presentation/widgets/profile_display.dart';

import '../../../../../config/router/router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
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
    return BlocProvider(
        create: (_) => sl<UserDataBloc>()..add(const UserDataLoad()),
        child: MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is SignedInPageState) {}
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
            child:
                // ProfileDisplay()
                BlocBuilder<UserDataBloc, UserDataState>(
              builder: (context, state) {
                if (state is UserDataLoaded) {
                  return ProfileDisplay(userData: state.userData);
                }
                if (state is UserDataFailure) {}
                return const LoadingWidget();
              },
            )));
  }
}
