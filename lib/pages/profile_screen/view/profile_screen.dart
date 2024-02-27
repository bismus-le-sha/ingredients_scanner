import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_scanner/user_auth/auth_service/firebase_auth_service.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: MaterialButton(
        onPressed: () => _authService.signOut(_scaffoldKey),
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
}
