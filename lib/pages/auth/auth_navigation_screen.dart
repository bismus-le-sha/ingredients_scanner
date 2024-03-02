import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

//TODO:  Is this class necessary?
@RoutePage()
class AuthNavigationScreen extends StatelessWidget {
  const AuthNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
