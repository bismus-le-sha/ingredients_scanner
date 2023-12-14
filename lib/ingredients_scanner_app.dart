import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ingredients_scanner/router/router.dart';
import 'package:ingredients_scanner/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class IngredientsSannerApp extends StatefulWidget {
  const IngredientsSannerApp({super.key});

  @override
  State<IngredientsSannerApp> createState() => _IngredientsSannerAppState();
}

class _IngredientsSannerAppState extends State<IngredientsSannerApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ingredients Scanner',
      theme: mainTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
      ),
    );
  }
}
