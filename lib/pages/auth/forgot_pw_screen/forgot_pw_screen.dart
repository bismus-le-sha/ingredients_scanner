import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../user_auth/auth_service/firebase_auth_service.dart';

@RoutePage()
class ForgotPwScreen extends StatefulWidget {
  const ForgotPwScreen({super.key});

  @override
  State<ForgotPwScreen> createState() => _ForgotPwScreenState();
}

class _ForgotPwScreenState extends State<ForgotPwScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Receive an email to reset your password",
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                validator: (String? value) {
                  return value == null || value.isEmpty
                      ? 'Please enter your email'
                      : !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                          ? 'Please enter a valid email address'
                          : null;
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  prefixIcon: const Icon(
                    Iconsax.user,
                    color: Colors.black,
                    size: 18,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _emailController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            SizedBox(
              // width: size.width * 0.36,
              child: MaterialButton(
                onPressed: () => _authService.resetPassword(
                    _emailController.text.trim(), _scaffoldKey),
                height: size.height * .045,
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  "Reset password",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
