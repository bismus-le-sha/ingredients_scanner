import 'package:local_auth/local_auth.dart';

import '../../other/domain/models/auth_data/user_auth_storage.dart';

class AuthService {
  final _localAuth = LocalAuthentication();
  final _authStorage = UserAuthStorage();

  Future<void> readFromStorage(emailController, passwordController) async {
    var enableLocalAuth = await _authStorage.getEnableLocalAuth();
    emailController = await _authStorage.getEmail() ?? '';
    passwordController = await _authStorage.getPassword() ?? '';

    if (enableLocalAuth != null && "true" == enableLocalAuth) {
      if (await _authenticateIsAvailable()) {
        bool didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'Please authenticate to sign in');
        if (!didAuthenticate) {
          emailController = '';
          passwordController = '';
        }
      }
    }
  }

  Future<bool> _authenticateIsAvailable() async {
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }
}
