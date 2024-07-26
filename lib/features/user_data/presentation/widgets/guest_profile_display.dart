import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_scanner/config/router/router.dart';

class GuestProfileDisplay extends StatefulWidget {
  const GuestProfileDisplay({super.key});

  @override
  State<GuestProfileDisplay> createState() => _GuestProfileDisplayState();
}

class _GuestProfileDisplayState extends State<GuestProfileDisplay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: _list(size),
    );
  }

  Widget _createAccount(size) {
    return MaterialButton(
      onPressed: () => context.pushRoute(const AuthNavigationRoute()),
      height: size.height * .045,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Text(
        "I'd like to fix that.",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
    );
  }

  Widget _list(Size size) {
    return ListView(
      children: [
        SizedBox(
          height: size.height * .05,
        ),
        //profil pic
        Icon(
          Icons.person,
          size: size.height * .2,
        ),
        SizedBox(
          height: size.height * .02,
        ),
        //user name
        const Text(
          'You have not yet created or logged into your account',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * .3,
        ),
        Center(child: _createAccount(size))
      ],
    );
  }
}
