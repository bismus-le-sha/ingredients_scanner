import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/router/router.dart';
import '../../../domain/entities/sign_up_entity.dart';
import '../../bloc/authentication/auth_bloc.dart';
import 'auth_fields.dart';

import 'auth_buttons.dart';
import 'helpers.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    SignUpEntity entity = SignUpEntity(
      email: _emailController.text,
      password: _passwordController.text,
      repeatedPassword: _confirmPasswordController.text,
      name: _usernameController.text,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            UsernameField(controller: _usernameController),
            const SizedBox(height: 20),
            EmailField(controller: _emailController),
            const SizedBox(height: 20),
            PasswordField(
              controller: _passwordController,
              isVisible: isVisible,
              toggleVisibility: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
            ),
            const SizedBox(height: 20),
            ConfirmPasswordField(
              controller: _confirmPasswordController,
              passwordController: _passwordController,
              isVisible: isVisible,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(listener: (_, state) {
              if (state is SignedUpState) {
                AutoRouter.of(context).replace(
                  VerifyEmailRoute(email: entity.email),
                );
                BlocProvider.of<AuthBloc>(context)
                    .add(SendEmailVerificationEvent());
              }
            }, builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ErrorAuthState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    AuthButton(
                        formKey: _formKey,
                        buttonText: 'Signup',
                        onSubmit: _onFormSubmit(entity))
                  ],
                );
              }
              return AuthButton(
                  formKey: _formKey,
                  buttonText: 'Signup',
                  onSubmit: _onFormSubmit(entity));
            }),
            const SizedBox(height: 20),
            const CustomDivider(),
            const SizedBox(height: 20),
            GoogleAuthButton(onGoogleAuth: _onGoogleAuth),
            const LoginPrompt(),
          ],
        ),
      ),
    );
  }

  _onFormSubmit(SignUpEntity entity) {
    BlocProvider.of<AuthBloc>(context).add(SignUpEvent(signUpEntity: entity));
  }

  _onGoogleAuth() {
    BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
  }
}
