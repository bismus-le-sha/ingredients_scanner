import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../config/router/router.dart';
import '../../../domain/entities/sign_in_entity.dart';
import '../../bloc/authentication/auth_bloc.dart';
import 'auth_buttons.dart';
import 'auth_fields.dart';
import 'helpers.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            EmailField(controller: _emailController),
            const SizedBox(height: 20),
            PasswordField(
              controller: _passwordController,
              isVisible: _obscureText,
              toggleVisibility: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is SignedInState) {
                BlocProvider.of<AuthBloc>(context).add(CheckLoggingInEvent());
              } else if (state is SignedInPageState ||
                  state is GoogleSignInState) {
                AutoRouter.of(context).replace(const HomeNavigationRoute());
              } else if (state is VerifyEmailPageState) {
                AutoRouter.of(context)
                    .push(VerifyEmailRoute(email: _emailController.text));
                BlocProvider.of<AuthBloc>(context)
                    .add(SendEmailVerificationEvent());
              }
            }, builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: LoadingAnimationWidget.threeRotatingDots(
                      color: Colors.black, size: 10),
                );
              }
              if (state is ErrorAuthState) {
                return Column(
                  children: [
                    Center(
                      child: Text(state.message),
                    ),
                    AuthButton(
                      formKey: _formKey,
                      buttonText: 'Login',
                      onSubmit: _onFormSubmit,
                    ),
                  ],
                );
              }
              return AuthButton(
                formKey: _formKey,
                buttonText: 'Login',
                onSubmit: _onFormSubmit,
              );
            }),
            const CustomDivider(),
            const SizedBox(height: 20),
            GoogleAuthButton(onGoogleAuth: _onGoogleAuth),
            const SignInPrompt(),
          ],
        ),
      ),
    );
  }

  void _onFormSubmit() {
    BlocProvider.of<AuthBloc>(context).add(SignInEvent(
      signInEntity: SignInEntity(
        password: _passwordController.text,
        email: _emailController.text,
      ),
    ));
  }

  void _onGoogleAuth() {
    BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
  }
}
