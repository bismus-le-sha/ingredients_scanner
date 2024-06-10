import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ingredients_scanner/features/camera_controller/domain/usecase/change_camera_flash.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/add_google_user_data.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/get_user_data.dart';
import 'package:ingredients_scanner/features/user_data/domain/usecases/add_update_user_data.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/camera_controller/data/datasource/camera_controller_data_source.dart';
import 'features/camera_controller/domain/usecase/dispose_camera_controller.dart';
import 'core/util/gallery_controller/data/datasources/gallery_controller_data_source.dart';
import 'core/util/gallery_controller/domain/repositories/gallery_controller_repository.dart';
import 'core/util/gallery_controller/domain/usecases/get_from_gallery.dart';
import 'features/camera_controller/presentation/bloc/camera_controller_bloc.dart';
import 'features/text_recognition/data/datasources/text_recognition_data_source.dart';
import 'features/text_recognition/data/repositories/text_recognition_repository_impl.dart';
import 'features/text_recognition/domain/repositories/text_recognition_repository.dart';
import 'features/text_recognition/domain/usecases/get_recognized_text_usecase.dart';
import 'features/text_recognition/presentation/bloc/text_recognition_bloc.dart';
import 'features/camera_controller/data/repository/camera_controller_repository_impl.dart';
import 'features/camera_controller/domain/repository/camera_controller_repository.dart';
import 'features/camera_controller/domain/usecase/init_camera_controller.dart';
import 'features/camera_controller/domain/usecase/take_picture_from_camera.dart';
import 'features/food_preferences/data/datasources/local/local_food_preferences_data_source.dart';
import 'features/food_preferences/data/datasources/remote/remote_food_preference_data_source.dart';
import 'features/food_preferences/data/repositories/food_preferences_repository_impl.dart';
import 'features/food_preferences/domain/repositories/food_preferences_repository.dart';
import 'features/food_preferences/domain/usecases/get_food_preferences_usecase.dart';
import 'features/food_preferences/domain/usecases/update_food_preferences.dart';
import 'features/food_preferences/presentation/bloc/food_preferences_bloc.dart';
import 'core/util/gallery_controller/data/repositories/gallery_controller_repository_impl.dart';
import 'features/user_data/data/datasources/local/local_user_data_data_source.dart';
import 'features/user_data/data/datasources/remote/remote_user_data_data_source.dart';
import 'features/user_data/data/repositories/user_data_repository_impl.dart';
import 'features/user_data/domain/repositories/user_data_repository.dart';
import 'features/user_data/presentation/bloc/user_data_bloc.dart';
import 'features/user_preferences/data/data_sources/user_preferences_data_source.dart';
import 'features/user_preferences/data/repositories/user_preferences_repository_imp.dart';
import 'features/user_preferences/domain/repositories/user_preferences_repositiory.dart';
import 'features/user_preferences/domain/usecases/get_user_preference.dart';
import 'features/user_preferences/presentation/bloc/user_preferences_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/router/router.dart';
import 'core/util/network/network_info.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'features/user_preferences/domain/usecases/update_user_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Auth

  // Bloc
  sl.registerFactory(() => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      firstPageUseCase: sl(),
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
      () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), googleSignIn: sl()));

//! Features - UserPreferences

  // Bloc
  sl.registerLazySingleton(() => UserPreferencesBloc(
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
  sl.registerLazySingleton(() => FoodPreferencesBloc(
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

//! Features - TextRecognition

  //Bloc
  sl.registerFactory(
      () => TextRecognitionBloc(getRecognizedText: sl(), getFromGallery: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetRecognizedText(sl()));

  //Repository
  sl.registerLazySingleton<TextRecognitionRepository>(
      () => TextRecognitionRepositoryImpl(textRecognizer: sl()));

  //Datasources
  sl.registerLazySingleton<TextRecognitionDataSource>(
      () => TextRecognitionDataSourceImpl(textRecognizer: sl()));

//! Features - UserData

  //Bloc
  sl.registerLazySingleton(() => UserDataBloc(
      getUserData: sl(), addUpdateUserData: sl(), addGoogleUserData: sl()));

  //Usecases
  sl.registerLazySingleton(() => GetUserData(sl()));
  sl.registerLazySingleton(() => AddUpdateUserData(sl()));
  sl.registerLazySingleton(() => AddGoogleUserData(sl()));

  //Repository
  sl.registerLazySingleton<UserDataRepository>(() => UserDataRepositoryImpl(
      remoteDataDataSource: sl(),
      localDataDataSource: sl(),
      networkInfo: sl()));

  //Datasources
  sl.registerLazySingleton<RemoteUserDataDataSource>(
      () => RemoteUserDataDataSourceImpl(instance: sl(), firebaseAuth: sl()));
  sl.registerLazySingleton<LocalUserDataDataSource>(
      () => LocalUserDataDataSourceImpl(sharedPreferences: sl()));

//! Core - GalleryController

  //Usecases
  sl.registerLazySingleton(() => GetFromGallery(sl()));

  //Repository
  sl.registerLazySingleton<GalleryControllerRepository>(
      () => GalleryControllerRepositoryImpl(galleryDataSource: sl()));

  //Datasources
  sl.registerLazySingleton<GalleryControllerDataSource>(
      () => GalleryControllerDataSourceImpl());

//! Core - Camera

  //Bloc
  sl.registerFactory<CameraControllerBloc>(() => CameraControllerBloc(
      initCameraController: sl(),
      takePictureFromCamera: sl(),
      disposeCameraController: sl(),
      changeCameraFlash: sl()));

  //Usecases
  sl.registerLazySingleton(() => InitCameraController(sl()));
  sl.registerLazySingleton(() => TakePictureFromCamera(sl()));
  sl.registerLazySingleton(() => DisposeCameraController(sl()));
  sl.registerLazySingleton(() => ChangeCameraFlash(sl()));

  //Repository
  sl.registerLazySingleton<CameraControllerRepository>(
      () => CameraControllerRepositoryImpl(dataSource: sl()));

  //Datasource
  final List<CameraDescription> cameras = await availableCameras();
  sl.registerLazySingleton<CameraControllerDataSource>(
      () => CameraControllerDataSourceImpl(cameras: cameras));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  //FirebaseAuth
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  //FirebaseFirestore
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  //IntnetConnection
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());

  //TextRecognizer
  sl.registerLazySingleton<TextRecognizer>(() => TextRecognizer());

//! Config

  //AppRouter
  sl.registerSingleton<AppRouter>(AppRouter());

  //Debug Talker
  sl.registerSingleton<Talker>(TalkerFlutter.init());
}
