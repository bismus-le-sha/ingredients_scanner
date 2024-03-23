import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/router.dart';
import '../../../authentication/presentation/bloc/authentication/auth_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoggedOutState) {
                context.replaceRoute(const AuthNavigationRoute());
              }
            },
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('Profile Screen'),
              ),
              body: MaterialButton(
                onPressed: () =>
                    BlocProvider.of<AuthBloc>(context).add(LogOutEvent()),
                height: size.height * .045,
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            )));
  }
}
