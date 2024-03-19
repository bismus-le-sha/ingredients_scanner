import '../../logs/const_error_messages.dart';

class FirebaseAuthExceptionHandler {
  FirebaseAuthExceptionHandler({required this.errorCode});
  final String errorCode;

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "wrong-password":
      case "user-not-found":
        return wrongPassword;
      case "invalid-email":
        return invalidEmail;
      case "user-disabled":
        return userDisabled;
      case "email-already-in-use":
        return emailAlreadyInUse;
      case "operation-not-allowed":
        return operationNotAllowed;
      case "weak-password":
        return weakPassword;
      case "account-exists-with-different-credential":
        return accountExistsWithDifferentCredential;
      case "invalid-credential":
        return invalidCredential;
      case "expired-action-code":
        return expiredActionCode;
      default:
        return loginFailed;
    }
  }
}
