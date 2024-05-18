import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/router.dart';
import '../../bloc/authentication/auth_bloc.dart';

@RoutePage()
class VerifyEmailPage extends StatefulWidget {
  final String email;
  const VerifyEmailPage({super.key, required this.email});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(CheckEmailVerificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String email = widget.email;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(50),
                child: Image(
                    height: 200,
                    width: 200,
                    image: AssetImage("assets/images/verify_page.jpg")),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Verify your E-Mail address',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (BuildContext context, AuthState state) {
                  if (state is EmailIsVerifiedState) {
                    AutoRouter.of(context).replace(const HomeNavigationRoute());
                  }
                },
                builder: (context, state) {
                  if (state is EmailIsSentState) {
                    return Center(
                        child: Text(
                      'A confirmation email has been sent to $email; please verify your account to continue.',
                      textAlign: TextAlign.center,
                    ));
                  } else if (state is ErrorAuthState) {
                    return Center(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center));
                  } else {
                    return const Center(
                        child: Text('Sending verification email...',
                            textAlign: TextAlign.center));
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Did not receive any email?"),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(SendEmailVerificationEvent());
                      },
                      child: const Text("resend email"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
