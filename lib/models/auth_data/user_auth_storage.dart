import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ingredients_scanner/models/auth_data/abstract_user_auth_storage.dart';

class UserAuthStorage implements AbstractUserAuthStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyUsername = 'userName';
  static const _keyPassword = 'password';
  static const _enableLocalAuth = 'enableLocalAuth';

  @override
  Future setEmail(String username) async =>
      await _storage.write(key: _keyUsername, value: username);

  @override
  Future<String?> getEmail() async => await _storage.read(key: _keyUsername);

  @override
  Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  @override
  Future<String?> getPassword() async => await _storage.read(key: _keyPassword);

  @override
  Future setEnableLocalAuth(String enableLocalAuth) async =>
      await _storage.write(key: _enableLocalAuth, value: enableLocalAuth);

  @override
  Future<String?> getEnableLocalAuth() async =>
      await _storage.read(key: _enableLocalAuth);
}
