import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ingredients_scanner/router/router.dart';
import 'package:ingredients_scanner/user_auth/firebase_auth/firebase_auth_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: MaterialButton(
        onPressed: _signOut,
        height: size.height * .045,
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await _authService.signOut();
      AutoRouter.of(context).push(const LoginRoute());
      GetIt.I<Talker>().debug('successful user logout');
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }
}
