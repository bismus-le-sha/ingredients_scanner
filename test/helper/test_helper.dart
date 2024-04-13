import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingredients_scanner/core/network/network_info.dart';
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
  RemoteFoodPreferencesDataSourceImpl,
  LocalFoodPreferencesDataSourceImpl,
  GetFoodPreferences,
  UpdateFoodPreferences,
  CollectionReference,
  NetworkInfo,
  FirebaseFirestore,
  //internet_connection_checker_plus
  InternetConnection
])
void main() {}
