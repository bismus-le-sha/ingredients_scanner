import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'config/router/router.dart';
import 'config/theme/app_theme.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/user_data/presentation/bloc/user_data_bloc.dart';
import 'injection_container.dart' as di;

class IngredientsSannerApp extends StatefulWidget {
  const IngredientsSannerApp({super.key});

  @override
  State<IngredientsSannerApp> createState() => _IngredientsSannerAppState();
}

class _IngredientsSannerAppState extends State<IngredientsSannerApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<AuthBloc>()..add(CheckLoggingInEvent())),
          BlocProvider(create: (_) => di.sl<UserDataBloc>())
        ],
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignedInPageState || state is GoogleSignInState) {
              BlocProvider.of<UserDataBloc>(context).add(const UserDataLoad());
            }
          },
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              return MaterialApp.router(
                title: 'Ingredients Scanner',
                theme: appTheme,
                debugShowCheckedModeBanner: false,
                routerDelegate: AutoRouterDelegate(
                  di.sl<AppRouter>(),
                  navigatorObservers: () =>
                      [TalkerRouteObserver(di.sl<Talker>())],
                ),
                routeInformationParser: di.sl<AppRouter>().defaultRouteParser(),
              );
            });
          },
        ));
  }
}
