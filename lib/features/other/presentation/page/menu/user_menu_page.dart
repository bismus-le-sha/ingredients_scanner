import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../config/router/router.dart';

@RoutePage()
class UserMenuPage extends StatefulWidget {
  const UserMenuPage({super.key});

  @override
  State<UserMenuPage> createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/head_page.jpg',
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
            TextButton(
              onPressed: () => context.pushRoute(const ProfileRoute()),
              child: const Text(
                'Profil',
              ),
            ),
            TextButton(
                onPressed: () => context.pushRoute(const FoodPreferenceRoute()),
                child: const Text('Food Preference')),
            TextButton(
                onPressed: () =>
                    context.pushRoute(const UserPreferencesRoute()),
                child: const Text('Settings'))
          ],
        ),
      ),
    );
  }
}
