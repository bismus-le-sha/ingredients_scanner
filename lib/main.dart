import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'features/other/domain/models/settings/user_pereference.dart';
import 'firebase_options.dart';
import 'ingredients_scanner_app.dart';
import 'injection_container.dart' as di;

void main() async {
  final talker = TalkerFlutter.init();

  GetIt.I.registerSingleton(talker);

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final preferences = await UserPreferences.getUserPreferences();
    GetIt.I.registerSingleton(preferences);
    runApp(const IngredientsSannerApp());
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
