import 'package:firebase_auth/firebase_auth.dart';
import 'package:ingredients_scanner/core/network/network_info.dart';
import 'package:ingredients_scanner/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:ingredients_scanner/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_local_data_sources.dart';
import 'package:ingredients_scanner/features/user_preferences/data/data_sources/user_preferences_remote_data_source.dart';
import 'package:ingredients_scanner/features/user_preferences/domain/repositories/user_preferences_repositiory.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  //auth
  AuthenticationRepository,
  UserCredential,
  AuthRemoteDataSource,
  //user_preferences
  UserPreferencesRepository,
  UserPreferencesLocalDataSource,
  UserPreferencesRemoteDataSource,
  NetworkInfo
])
void main() {}
