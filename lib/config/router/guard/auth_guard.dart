import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/authentication/presentation/bloc/auth_bloc.dart';
import '../router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    BlocListener<AuthBloc, AuthState>(listener: (context, state) {
      if (state is SignedInPageState ||
          state is GoogleSignInState ||
          state is SignedUpState) {
        resolver.next(true);
      } else {
        context.pushRoute(const AuthNavigationRoute());
      }
    });
  }
}
