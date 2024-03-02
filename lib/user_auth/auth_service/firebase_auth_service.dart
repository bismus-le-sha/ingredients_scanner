import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ingredients_scanner/global/widgets/message_snack_bar.dart';
import 'package:ingredients_scanner/models/settings/user_pereference.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:local_auth/local_auth.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../models/auth_data/user_auth_storage.dart';
import '../../pages/auth/login_screen/widgets/enable_local_auth_modal_bottom_sheet.dart';
import '../../router/router.gr.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MessageSnackBar _snackBar = MessageSnackBar();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;

  final UserAuthStorage _authStorage = UserAuthStorage();
  var localAuth = LocalAuthentication();

  Future<User?> _signUpWithEmailAndPassword(
      String email, String password, GlobalKey scaffoldKey) async {
    final scaffoldMessenger = ScaffoldMessenger.of(scaffoldKey.currentContext!);
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'email-already-in-use') {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('The email addre is already in use.'));
        GetIt.I<Talker>().debug(
            'The user tries to create an account with an e-mail address already in use.');
      } else if (e.code == 'weak-password') {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('The password provided is too weak.'));
        GetIt.I<Talker>()
            .debug('The password entered by the user is too weak.');
      } else {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('An error occurred: ${e.code}'));
        GetIt.I<Talker>().handle(e, st);
      }
    }
    return null;
  }

  Future<User?> _signInWithEmailAndPassword(
      String email, String password, GlobalKey scaffoldKey) async {
    final scaffoldMessenger = ScaffoldMessenger.of(scaffoldKey.currentContext!);
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e, st) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        scaffoldMessenger.showSnackBar(_snackBar.popUpSnackBar(
            _snackBar.popUpSnackBar('Invalid email or password.')));
        GetIt.I<Talker>()
            .debug('The email or password entered by the user is not correct.');
      } else {
        scaffoldMessenger.showSnackBar(
            _snackBar.popUpSnackBar('An error occurred: ${e.code}'));
        GetIt.I<Talker>().handle(e, st);
      }
    }
    return null;
  }

  Future<void> _signOutHandler() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      GetIt.I<Talker>().debug('User logged out.');
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> _signInWithCredential(credential, scaffoldKey) async {
    final scaffoldMessenger = ScaffoldMessenger.of(scaffoldKey.currentContext!);
    try {
      await _auth.signInWithCredential(credential);
      GetIt.I<Talker>().debug('The user is logged in with credential.');
    } on FirebaseAuthException catch (e, st) {
      scaffoldMessenger.showSnackBar(
          _snackBar.popUpSnackBar('An error occurred: ${e.code}'));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> signInWithGoogle(scaffoldKey) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await _signInWithCredential(credential, scaffoldKey);
        _checkForEnableLocalAuth(scaffoldKey);
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  //TODO: redesign the logic to go to another page
  _checkForEnableLocalAuth(scaffoldKey) async {
    if (await localAuth.canCheckBiometrics) {
      showModalBottomSheet<void>(
        context: scaffoldKey.currentContext,
        builder: (BuildContext context) {
          return EnableLocalAuthModalBottomSheet(
              action: () => _onEnableLocalAuth(scaffoldKey));
        },
      ).then((value) => AutoRouter.of(scaffoldKey.currentContext!)
          .push(const HomeNavigationRoute()));
    } else {
      AutoRouter.of(scaffoldKey.currentContext!)
          .push(const HomeNavigationRoute());
    }
  }

  _onEnableLocalAuth(scaffoldKey) async {
    _authStorage.setEnableLocalAuth('true');

    SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!)
          .showSnackBar(const SnackBar(
        content: Text(
            "Fingerprint authentication enabled.\nClose the app and restart it again"),
      ));
    });
  }

  Future<void> signIn(email, password, scaffoldKey) async {
    try {
      _user = await _signInWithEmailAndPassword(email, password, scaffoldKey);

      if (_user != null) {
        GetIt.I<Talker>().debug('successful user login');
        _checkForEnableLocalAuth(scaffoldKey);
        _loggedIn();
      } else {
        GetIt.I<Talker>().debug('user null');
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  Future<void> signOut(scaffoldKey) async {
    try {
      await _signOutHandler();
      _loggedOut();
      AutoRouter.of(scaffoldKey.currentContext!)
          .push(LoginRoute(onResult: (bool) {}));
      GetIt.I<Talker>().debug('successful user logout');
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  signUp(email, password, scaffoldKey) async {
    _user = await _signUpWithEmailAndPassword(email, password, scaffoldKey);

    if (_user != null) {
      GetIt.I<Talker>().debug('successful user registration');
      AutoRouter.of(scaffoldKey.currentContext!)
          .push(const HomeNavigationRoute());
    } else {
      GetIt.I<Talker>().debug('user null');
    }
  }

  Future resetPassword(email, scaffoldKey) async {
    showDialog(
        context: scaffoldKey.currentContext!,
        barrierDismissible: false,
        builder: (context) => Center(
            child: LoadingAnimationWidget.threeRotatingDots(
                color: Colors.black, size: 100)));
    final scaffoldMessenger = ScaffoldMessenger.of(scaffoldKey.currentContext!);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      GetIt.I<Talker>().debug('successful send reset password email');
      scaffoldMessenger
          .showSnackBar(_snackBar.popUpSnackBar('Password reset email sent'));
      AutoRouter.of(scaffoldKey.currentContext!)
          .push(LoginRoute(onResult: (bool) {}));
    } on FirebaseAuthException catch (e, st) {
      scaffoldMessenger.showSnackBar(
          _snackBar.popUpSnackBar('An error occurred: ${e.code}'));
      GetIt.I<Talker>().handle(e, st);
    }
  }

  _loggedIn() async {
    final preferences = await UserPreferences.getUserPreferences();
    preferences.setAuthenticated(true);
  }

  _loggedOut() async {
    final preferences = await UserPreferences.getUserPreferences();
    preferences.setAuthenticated(false);
  }

  Future<bool> isAuthenticate() async {
    final preferences = await UserPreferences.getUserPreferences();
    return preferences.getAuthenticated() ?? false;
  }
}
