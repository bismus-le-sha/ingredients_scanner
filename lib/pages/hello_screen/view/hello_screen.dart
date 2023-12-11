import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ingredients_scanner/router/router.dart';

@RoutePage()
class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  final theme = Theme.of(context);
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                AutoRouter.of(context).push(const AllergyRoute());
              },
              child: const Text('Start'))),
    );
  }
}
