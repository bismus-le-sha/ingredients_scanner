import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/router.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/sign_in_form.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignedInState) {
          BlocProvider.of<AuthBloc>(context).add(CheckLoggingInEvent());
        } else if (state is SignedInPageState || state is GoogleSignInState) {
          context.navigateTo(const ProfileRoute());
        }
      },
      child: Scaffold(
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(
                  height: 200,
                  width: 200,
                  image: AssetImage("assets/images/3.jpg")),
            ),
            Center(
                child: Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
