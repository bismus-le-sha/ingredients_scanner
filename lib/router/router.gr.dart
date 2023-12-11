// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AllergyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AllergyScreen(),
      );
    },
    HelloRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HelloScreen(),
      );
    },
  };
}

/// generated route for
/// [AllergyScreen]
class AllergyRoute extends PageRouteInfo<void> {
  const AllergyRoute({List<PageRouteInfo>? children})
      : super(
          AllergyRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllergyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HelloScreen]
class HelloRoute extends PageRouteInfo<void> {
  const HelloRoute({List<PageRouteInfo>? children})
      : super(
          HelloRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelloRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
