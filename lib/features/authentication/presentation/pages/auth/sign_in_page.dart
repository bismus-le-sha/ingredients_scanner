import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth/sign_in_form.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
