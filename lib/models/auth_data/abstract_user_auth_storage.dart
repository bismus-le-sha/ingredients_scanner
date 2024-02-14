abstract class AbstractUserAuthStorage {
  Future setEmail(String username);
  Future<String?> getEmail();
  Future setPassword(String password);
  Future<String?> getPassword();
  Future setEnableLocalAuth(String enableLocalAuth);
  Future<String?> getEnableLocalAuth();
}
