import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:ingredients_scanner/core/util/network/network_info.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/data/datasources/gallery_controller_data_source.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/domain/repositories/gallery_controller_repository.dart';
import 'package:ingredients_scanner/core/util/gallery_controller/domain/usecases/get_from_gallery.dart';
import 'package:ingredients_scanner/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:ingredients_scanner/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/check_verification_usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/first_page_usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/google_auth_usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/logout_usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:ingredients_scanner/features/authentication/domain/usecases/verifiy_email_usecase.dart';
import 'package:ingredients_scanner/features/food_preferences/data/datasources/local/local_food_preferences_data_source.dart';
import 'package:ingredients_scanner/features/food_preferences/data/datasources/remote/remote_food_preference_data_source.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/repositories/food_preferences_repository.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/usecases/get_food_preferences_usecase.dart';
import 'package:ingredients_scanner/features/food_preferences/domain/usecases/update_food_preferences.dart';
import 'package:ingredients_scanner/features/text_recognition/data/datasources/text_recognition_data_source.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/repositories/text_recognition_repository.dart';
import 'package:ingredients_scanner/features/text_recognition/domain/usecases/get_recognized_text_usecase.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_data_source.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/get_user_preference.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/usecases/update_user_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:ingredients_scanner/features/user_preferences/domain/repositories/user_preferences_repositiory.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  //auth
  AuthenticationRepository,
  UserCredential,
  AuthRemoteDataSource,
  SignInUseCase,
  SignUpUseCase,
  VerifyEmailUseCase,
  LogOutUseCase,
  FirstPageUseCase,
  CheckVerificationUseCase,
  GoogleAuthUseCase,
  //user_preferences
  UserPreferencesRepository,
  UserPreferencesDataSource,
  SharedPreferences,
  GetUserPreferences,
  UpdateUserPreferences,
  //food_preferences
  FoodPreferencesRepository,
  RemoteFoodPreferencesDataSource,
  LocalFoodPreferencesDataSource,
  GetFoodPreferences,
  UpdateFoodPreferences,
  CollectionReference,
  NetworkInfo,
  FirebaseFirestore,
  //text_recognition
  TextRecognitionRepository,
  TextRecognitionDataSource,
  TextRecognizer,
  GetRecognizedText,
  //gallery_controller
  GalleryControllerRepository,
  GalleryControllerDataSource,
  GetFromGallery,
  BuildContext,
  MediaFile,
  //internet_connection_checker_plus
  InternetConnection
])
void main() {}
