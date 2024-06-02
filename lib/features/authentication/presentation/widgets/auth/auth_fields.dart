import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:email_validator/email_validator.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Username',
          prefixIcon: Icon(
            Iconsax.user,
            size: 18,
          ),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'E-Mail',
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
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback toggleVisibility;

  const PasswordField({
    required this.controller,
    required this.isVisible,
    required this.toggleVisibility,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: 'Create password',
          prefixIcon: const Icon(
            Iconsax.key,
            size: 18,
          ),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Iconsax.eye4 : Iconsax.eye_slash4,
              color: Colors.grey,
            ),
            onPressed: toggleVisibility,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          } else if (value.length < 5) {
            return 'The password must contain more than five characters.';
          }
          return null;
        },
      ),
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final bool isVisible;

  const ConfirmPasswordField({
    required this.controller,
    required this.passwordController,
    required this.isVisible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        decoration: const InputDecoration(
          labelText: 'Confirm password',
          prefixIcon: Icon(
            Iconsax.key,
            size: 18,
          ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password confirmation';
          } else if (value != passwordController.text) {
            return "Password doesn't match.";
          }
          return null;
        },
      ),
    );
  }
}
