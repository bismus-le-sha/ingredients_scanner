import 'package:get_it/get_it.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_data_source.dart';
import 'package:ingredients_scanner/features/user_preferences/data/repositories/user_preferences_repository_imp.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/repositories/user_preferences_repositiory.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/get_user_preference.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/update_use_biometrics.dart';
import 'package:ingredients_scanner/features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'config/router/router.dart';
import 'core/network/network_info.dart';
import 'features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/domain/usecases/check_verification_usecase.dart';
import 'features/authentication/domain/usecases/first_page_usecase.dart';
import 'features/authentication/domain/usecases/google_auth_usecase.dart';
import 'features/authentication/domain/usecases/logout_usecase.dart';
import 'features/authentication/domain/usecases/sign_in_usecase.dart';
import 'features/authentication/domain/usecases/sign_up_usecase.dart';
import 'features/authentication/domain/usecases/verifiy_email_usecase.dart';
import 'features/authentication/presentation/bloc/authentication/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/user_preferences/domain/usecases/update_camera_flash.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Auth

  // Bloc

  sl.registerFactory(() => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      firstPage: sl(),
      verifyEmailUseCase: sl(),
      checkVerificationUseCase: sl(),
      logOutUseCase: sl(),
      googleAuthUseCase: sl()));

  // Usecases

  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => FirstPageUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => CheckVerificationUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));
  sl.registerLazySingleton(() => GoogleAuthUseCase(sl()));

  // Repository

  sl.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImp(
          networkInfo: sl(), authRemoteDataSource: sl()));

  // Datasources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());

  //FirebaseAuth
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

//! Features - UserPreferences

  // Bloc

  sl.registerFactory(() => UserPreferencesBloc(
      getUserPreferences: sl(),
      updateUseBiometrics: sl(),
      updateCameraFlash: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetUserPreferences(sl()));
  sl.registerLazySingleton(() => UpdateCameraFlash(sl()));
  sl.registerLazySingleton(() => UpdateUseBiometrics(sl()));

  // Repository

  sl.registerLazySingleton<UserPreferencesRepository>(
      () => UserPreferencesRepositoryImpl(dataSource: sl()));

  // Datasources
  sl.registerLazySingleton<UserPreferencesDataSource>(
      () => UserPreferencesDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

//! Config

  sl.registerSingleton<AppRouter>(AppRouter());

  //Debug Talker
  sl.registerSingleton<Talker>(TalkerFlutter.init());
}
