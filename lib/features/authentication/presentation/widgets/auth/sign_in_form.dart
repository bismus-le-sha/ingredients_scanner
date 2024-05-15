import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../config/router/router.dart';
import '../../../domain/entities/sign_in_entity.dart';
import '../../bloc/authentication/auth_bloc.dart';

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
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.mail,
                    size: 18,
                  ),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your E-Mail';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid E-Mail';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: TextFormField(
                controller: _passwordController,
                obscureText: _obscureText ? false : true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(
                    Iconsax.key,
                    size: 18,
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Iconsax.eye4 : Iconsax.eye_slash4,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 5) {
                    return 'The password must contains more than five characters.';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
              if (state is SignedInState) {
                BlocProvider.of<AuthBloc>(context).add(CheckLoggingInEvent());
              } else if (state is SignedInPageState ||
                  state is GoogleSignInState) {
                AutoRouter.of(context).replace(const HomeNavigationRoute());
              } else if (state is VerifyEmailPageState) {
                AutoRouter.of(context).push(const VerifyEmailRoute());
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
                    _loginButton(context, const Text('Login'), _onFormSubmit),
                  ],
                );
              }
              return _loginButton(context, const Text('Login'), _onFormSubmit);
            }),
            Container(
                margin: const EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: const Divider(
                          thickness: 2,
                          color: Colors.grey,
                        )),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: const Text(
                          'OR',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              child: _loginButton(
                  context,
                  SvgPicture.asset('assets/svg/Google__G__logo.svg'),
                  _onGoogleAuth),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () =>
                        AutoRouter.of(context).push(const SignUpRoute()),
                    child: const Text("Sign up!"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _loginButton(
      BuildContext context, Widget child, VoidCallback onPress) {
    return ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
          minimumSize: WidgetStateProperty.all(const Size(500, 50)),
          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
        ),
        child: child);
  }

  _onFormSubmit() {
    BlocProvider.of<AuthBloc>(context).add(SignInEvent(
        signInEntity: SignInEntity(
            password: _passwordController.text, email: _emailController.text)));
  }

  _onGoogleAuth() {
    BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent());
  }
}
