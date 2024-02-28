import 'package:auto_route/auto_route.dart';
import 'package:ingredients_scanner/pages/bottom_nav_page.dart';
import 'package:ingredients_scanner/pages/auth/login_screen/view/login_screen.dart';
import '../pages/auth/forgot_pw_screen/forgot_pw_screen.dart';
import '../pages/food_preference_screen/view/food_preference_screen.dart';

import '../pages/home_screen/view/home_screen.dart';
import '../pages/profile_screen/view/profile_screen.dart';
import '../pages/scanner_screen/view/scanner_screen.dart';
import '../pages/settings_screen/view/settings_screen.dart';
import '../pages/auth/sign_screen/view/sign_screen.dart';
import '../pages/user_menu_screen/view/user_menu_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          // path: '/',
          page: BottomNavRoute.page,
          children: [
            AutoRoute(path: 'menu', page: UserMenuRoute.page),
            AutoRoute(path: 'home', page: HomeRoute.page),
            AutoRoute(path: 'scanner', page: ScannerRoute.page),
          ],
        ),
        AutoRoute(path: '/', page: LoginRoute.page),
        AutoRoute(page: SignRoute.page),
        AutoRoute(page: ForgotPwRoute.page),
        AutoRoute(page: FoodPreferenceRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ];
}
