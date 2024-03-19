import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/auth/sign_up_form.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                  image: AssetImage("assets/images/2.jpg")),
            ),
            Center(
                child: Text(
              "Signup",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
