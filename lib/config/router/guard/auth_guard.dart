import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ingredients_scanner/features/authentication/presentation/bloc/authentication/auth_bloc.dart';

import '../router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    BlocListener<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthInitial) {
        resolver.next(true);
      } else {
        resolver.redirect(const AuthNavigationRoute());
      }
    });
  }
}
