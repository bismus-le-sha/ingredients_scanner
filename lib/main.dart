import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'firebase_options.dart';
import 'ingredients_scanner_app.dart';
import 'injection_container.dart' as di;

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await di.init();

    final talker = di.sl<Talker>();

    Bloc.observer = TalkerBlocObserver(
      talker: talker,
      settings: const TalkerBlocLoggerSettings(
        printStateFullData: false,
        printEventFullData: false,
      ),
    );

    FlutterError.onError =
        (details) => talker.handle(details.exception, details.stack);

    // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    // await FirebaseStorage.instance.useStorageEmulator('localhost', 8085);

    runApp(const IngredientsSannerApp());
  }, (e, st) {
    di.sl<Talker>().handle(e, st);
  });
}
