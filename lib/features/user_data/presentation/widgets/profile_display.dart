import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/user_data/domain/entities/user_data_entity.dart';

import '../../../authentication/presentation/bloc/authentication/auth_bloc.dart';

class ProfileDisplay extends StatefulWidget {
  // final UserDataEntity userData;
  const ProfileDisplay({
    super.key,
  });

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: _list(size),
    );
  }

  Widget _logOut(size) {
    return MaterialButton(
      onPressed: () => BlocProvider.of<AuthBloc>(context).add(LogOutEvent()),
      height: size.height * .045,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Text(
        "Logout",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  Widget _list(Size size) {
    return ListView(
      children: [
        SizedBox(
          height: size.height * .05,
        ),
        //profil pic
        Icon(
          Icons.person,
          size: size.height * .2,
        ),
        SizedBox(
          height: size.height * .02,
        ),
        //user name
        const Text(
          'name',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * .02,
        ),
        //user email
        const Text(
          'email',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * .3,
        ),
        Center(child: _logOut(size))
      ],
    );
  }
}
