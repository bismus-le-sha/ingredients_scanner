import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AllergyScreen extends StatefulWidget {
  const AllergyScreen({super.key});

  @override
  State<AllergyScreen> createState() => _AllergyScreenState();
}

class _AllergyScreenState extends State<AllergyScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return const Scaffold(
      body: Center(),
    );
  }
}
