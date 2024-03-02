import 'package:auto_route/auto_route.dart';
import 'package:ingredients_scanner/router/guard/auth_guard.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeNavigationRoute.page,
          initial: true,
          guards: [AuthGuard()],
          children: [
            AutoRoute(path: 'menu', page: UserMenuRoute.page),
            AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
            AutoRoute(path: 'scanner', page: ScannerRoute.page),
          ],
        ),
        AutoRoute(
          page: AuthNavigationRoute.page,
          keepHistory: false,
          children: [
            AutoRoute(page: LoginRoute.page, initial: true),
            AutoRoute(page: SignRoute.page),
            AutoRoute(page: ForgotPwRoute.page),
          ],
        ),
        // AutoRoute(page: LoginRoute.page, keepHistory: false),
        // AutoRoute(page: SignRoute.page),
        // AutoRoute(page: ForgotPwRoute.page),
        AutoRoute(page: FoodPreferenceRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ];
}
