import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../router/router.dart';

// enum MenuScreenItems {
//   ACCOUNT('account'),
//   FOOD('food'),
//   SETTINGS('settings');

//   const MenuScreenItems(this.tag);

//   /// A tag used when opening a new screen
//   /// eg: preferences/account
//   final String tag;

//   AbstractUserParams getUserMenus({
//     required final UserParams userParams,
//     required final BuildContext context,
//   }) {
//     final ThemeData themeData = Theme.of(context);
//     final ProductPreferences productPreferences =
//         context.read<ProductPreferences>();

//     switch (this) {
//       case MenuScreenItems.ACCOUNT:
//         return UserMenuAccount(
//           context: context,
//           userParams: userParams,
//           themeData: themeData,
//         );
//       case MenuScreenItems.FOOD:
//         return UserMenuFood(
//           productPreferences: productPreferences,
//           context: context,
//           userParams: userParams,
//           themeData: themeData,
//         );
//       case MenuScreenItems.SETTINGS:
//         return UserMenuSettings(
//           context: context,
//           userParams: userParams,
//           themeData: themeData,
//         );
//     }
//   }

//   static List<MenuScreenItems> getMenuScreenItems(
//     final UserParams userParams,
//   ) =>
//       <MenuScreenItems>[
//         MenuScreenItems.ACCOUNT,
//         MenuScreenItems.FOOD,
//         MenuScreenItems.SETTINGS,
//       ];
// }

@RoutePage()
class UserMenuScreen extends StatefulWidget {
  const UserMenuScreen({super.key});

  @override
  State<UserMenuScreen> createState() => _UserMenuScreenState();
}

class _UserMenuScreenState extends State<UserMenuScreen> {
  @override
  Widget build(BuildContext context) {
    // final UserParams userParams = context.watch<UserParams>();
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
              onPressed: () => AutoRouter.of(context).push(const ProfileRoute()),
              child: const Text(
                'Profil',
              ),
            ),
            TextButton(
                onPressed: () => AutoRouter.of(context).push(const FoodPreferenceRoute()),
                child: const Text('Food Preference')),
            TextButton(
                onPressed: () => AutoRouter.of(context).push(const SettingsRoute()),
                child: const Text('Settings'))
          ],
        ),
      ),
    );
  }
}
