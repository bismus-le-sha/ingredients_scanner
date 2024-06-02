import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String buttonText;
  final VoidCallback onSubmit;

  const AuthButton({
    required this.formKey,
    required this.buttonText,
    required this.onSubmit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          onSubmit();
        }
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(500, 50)),
        textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
      ),
      child: Text(buttonText),
    );
  }
}

class GoogleAuthButton extends StatelessWidget {
  final VoidCallback onGoogleAuth;

  const GoogleAuthButton({required this.onGoogleAuth, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onGoogleAuth,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          minimumSize: WidgetStateProperty.all(const Size(500, 50)),
          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
        ),
        child: SvgPicture.asset('assets/svg/Google__G__logo.svg'),
      ),
    );
  }
}
