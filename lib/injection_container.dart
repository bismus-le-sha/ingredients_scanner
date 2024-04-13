import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'features/food_preferences/data/datasources/local/local_food_preferences_data_source.dart';
import 'features/food_preferences/data/datasources/remote/remote_food_preference_data_source.dart';
import 'features/food_preferences/data/repositories/food_preferences_repository_impl.dart';
import 'features/food_preferences/domain/repositories/food_preferences_repository.dart';
import 'features/food_preferences/domain/usecases/get_food_preferences_usecase.dart';
import 'features/food_preferences/domain/usecases/update_food_preferences.dart';
import 'features/food_preferences/presentation/bloc/food_preferences_bloc.dart';
import 'features/user_preferences/data/data_sources/user_preferences_data_source.dart';
import 'features/user_preferences/data/repositories/user_preferences_repository_imp.dart';
import 'features/user_preferences/domain/repositories/user_preferences_repositiory.dart';
import 'features/user_preferences/domain/usecases/get_user_preference.dart';
import 'features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
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
import 'features/user_preferences/domain/usecases/update_user_preferences.dart';

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
      getUserPreferences: sl(), updateUserPreferences: sl()));

  // Usecases
  sl.registerLazySingleton(() => GetUserPreferences(sl()));
  sl.registerLazySingleton(() => UpdateUserPreferences(sl()));

  // Repository
  sl.registerLazySingleton<UserPreferencesRepository>(
      () => UserPreferencesRepositoryImpl(dataSource: sl()));

  // Datasources
  sl.registerLazySingleton<UserPreferencesDataSource>(
      () => UserPreferencesDataSourceImpl(sharedPreferences: sl()));

//! Features - FoodPreferences

  //Bloc
  sl.registerFactory(() => FoodPreferencesBloc(
      getFoodPreferences: sl(), updateFoodPreferences: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetFoodPreferences(sl()));
  sl.registerLazySingleton(() => UpdateFoodPreferences(sl()));

  //Repository
  sl.registerLazySingleton<FoodPreferencesRepository>(() =>
      FoodPreferencesRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<RemoteFoodPreferencesDataSource>(
      () => RemoteFoodPreferencesDataSourceImpl(instance: sl()));
  sl.registerLazySingleton<LocalFoodPreferencesDataSource>(
      () => LocalFoodPreferencesDataSourceImpl(sharedPreferences: sl()));

  //FirebaseFirestore
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

//! Config

  sl.registerSingleton<AppRouter>(AppRouter());

  //Debug Talker
  sl.registerSingleton<Talker>(TalkerFlutter.init());
}
