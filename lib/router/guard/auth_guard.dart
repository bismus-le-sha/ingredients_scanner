import 'package:auto_route/auto_route.dart';

import '../../user_auth/auth_service/firebase_auth_service.dart';
import '../router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await _authService.isAuthenticate()) {
      resolver.next(true);
    } else {
      router.push(LoginRoute(onResult: (result) {
        if (result == true) {
          resolver.next(true);
          router.removeLast();
        }
      }));
    }
  }
}
