import 'package:auto_route/auto_route.dart';
import 'package:ingredients_scanner/pages/allergy_screen/view/allergy_screen.dart';
import 'package:ingredients_scanner/pages/hello_screen/view/hello_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HelloRoute.page, path: '/'),
        AutoRoute(page: AllergyRoute.page),
      ];
}
