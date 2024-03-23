import 'package:auto_route/auto_route.dart';
import '../../features/authentication/presentation/pages/auth/sign_in_page.dart';

import '../../features/authentication/presentation/pages/auth/sign_up_page.dart';
import '../../features/authentication/presentation/pages/auth/verify_email.dart';
import '../../features/authentication/presentation/pages/auth/auth_navigation_screen.dart';
import '../../features/other/presentation/page/food_preference_page.dart';
import '../../features/other/presentation/page/start_floor/home_navigation_page.dart';
import '../../features/other/presentation/page/start_floor/home_page.dart';
import '../../features/other/presentation/page/profile_page.dart';
import '../../features/other/presentation/page/start_floor/menu_navigation_page.dart';
import '../../features/other/presentation/page/start_floor/scanner_page.dart';
import '../../features/other/presentation/page/settings_page.dart';
import '../../features/other/presentation/page/user_menu_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeNavigationRoute.page,
          initial: true,
          children: [
            AutoRoute(path: 'menu', page: MenuNavigationRoute.page, children: [
              AutoRoute(page: UserMenuRoute.page, initial: true),
              AutoRoute(page: FoodPreferenceRoute.page),
              AutoRoute(page: SettingsRoute.page),
              AutoRoute(page: ProfileRoute.page),
            ]),
            AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
            AutoRoute(path: 'scanner', page: ScannerRoute.page),
          ],
        ),
        AutoRoute(
          page: AuthNavigationRoute.page,
          keepHistory: false,
          children: [
            AutoRoute(page: VerifyEmailRoute.page),
            AutoRoute(page: SignInRoute.page, initial: true),
            AutoRoute(page: SignUpRoute.page),
          ],
        ),
      ];
}
