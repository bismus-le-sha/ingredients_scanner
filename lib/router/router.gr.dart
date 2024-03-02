// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:ingredients_scanner/pages/auth/auth_navigation_screen.dart'
    as _i1;
import 'package:ingredients_scanner/pages/auth/forgot_pw_screen/forgot_pw_screen.dart'
    as _i3;
import 'package:ingredients_scanner/pages/auth/login_screen/view/login_screen.dart'
    as _i6;
import 'package:ingredients_scanner/pages/auth/sign_screen/view/sign_screen.dart'
    as _i10;
import 'package:ingredients_scanner/pages/food_preference_screen/view/food_preference_screen.dart'
    as _i2;
import 'package:ingredients_scanner/pages/home_navigation_page.dart' as _i4;
import 'package:ingredients_scanner/pages/home_screen/view/home_screen.dart'
    as _i5;
import 'package:ingredients_scanner/pages/profile_screen/view/profile_screen.dart'
    as _i7;
import 'package:ingredients_scanner/pages/scanner_screen/view/scanner_screen.dart'
    as _i8;
import 'package:ingredients_scanner/pages/settings_screen/view/settings_screen.dart'
    as _i9;
import 'package:ingredients_scanner/pages/user_menu_screen/view/user_menu_screen.dart'
    as _i11;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AuthNavigationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthNavigationScreen(),
      );
    },
    FoodPreferenceRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.FoodPreferenceScreen(),
      );
    },
    ForgotPwRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ForgotPwScreen(),
      );
    },
    HomeNavigationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeNavigationPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.LoginScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileScreen(),
      );
    },
    ScannerRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ScannerScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsScreen(),
      );
    },
    SignRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SignScreen(),
      );
    },
    UserMenuRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.UserMenuScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthNavigationScreen]
class AuthNavigationRoute extends _i12.PageRouteInfo<void> {
  const AuthNavigationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AuthNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthNavigationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.FoodPreferenceScreen]
class FoodPreferenceRoute extends _i12.PageRouteInfo<void> {
  const FoodPreferenceRoute({List<_i12.PageRouteInfo>? children})
      : super(
          FoodPreferenceRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodPreferenceRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ForgotPwScreen]
class ForgotPwRoute extends _i12.PageRouteInfo<void> {
  const ForgotPwRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ForgotPwRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPwRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeNavigationPage]
class HomeNavigationRoute extends _i12.PageRouteInfo<void> {
  const HomeNavigationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeNavigationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i13.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i12.PageInfo<LoginRouteArgs> page =
      _i12.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i13.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ScannerScreen]
class ScannerRoute extends _i12.PageRouteInfo<void> {
  const ScannerRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScannerRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SignScreen]
class SignRoute extends _i12.PageRouteInfo<void> {
  const SignRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SignRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UserMenuScreen]
class UserMenuRoute extends _i12.PageRouteInfo<void> {
  const UserMenuRoute({List<_i12.PageRouteInfo>? children})
      : super(
          UserMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserMenuRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
